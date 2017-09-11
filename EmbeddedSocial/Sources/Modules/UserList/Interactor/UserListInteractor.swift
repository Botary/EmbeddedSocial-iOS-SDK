//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

class UserListInteractor: UserListInteractorInput {
    typealias ListState = PaginatedResponse<User, String>
    
    weak var output: UserListInteractorOutput?

    private var api: UsersListAPI
    private let socialService: SocialServiceType
    private var pages: [Page] = []
    private var pendingPages: Set<String> = Set()
    
    var isLoadingList = false {
        didSet {
            output?.didUpdateListLoadingState(isLoadingList)
        }
    }
    
    private let queue = DispatchQueue(label: "UserListInteractor-queue")
    
    private var listState: ListState {
        let lastCursor = pages.last?.response.cursor
        let users = pages.flatMap { $0.response.users }
        return ListState(items: users, hasMore: lastCursor != nil, error: nil, cursor: lastCursor)
    }
    
    var listHasMoreItems: Bool {
        return listState.hasMore
    }

    init(api: UsersListAPI, socialService: SocialServiceType) {
        self.api = api
        self.socialService = socialService
    }
    
    func processSocialRequest(to user: User, completion: @escaping (Result<FollowStatus>) -> Void) {
        guard let followStatus = user.followerStatus else {
            completion(.failure(APIError.missingUserData))
            return
        }
        
        let nextStatus = FollowStatus.reduce(status: followStatus, visibility: user.visibility ?? ._private)
        
        socialService.request(currentFollowStatus: user.followerStatus ?? .empty, userID: user.uid) { result in
            if result.isSuccess {
                completion(.success(nextStatus))
            } else {
                completion(.failure(result.error ?? APIError.unknown))
            }
        }
    }
    
    func setAPI(_ api: UsersListAPI) {
        self.api = api
        resetLoadingState()
    }
    
    private func resetLoadingState() {
        pages = []
        isLoadingList = false
        pendingPages = Set()
    }
    
    func reloadList(completion: @escaping (Result<[User]>) -> Void) {
        resetLoadingState()
        getNextListPage(skipCache: true, completion: completion)
    }
    
    func getNextListPage(completion: @escaping (Result<[User]>) -> Void) {
        getNextListPage(skipCache: false, completion: completion)
    }
    
    private func getNextListPage(skipCache: Bool, completion: @escaping (Result<[User]>) -> Void) {
        isLoadingList = true
        
        let pageID = UUID().uuidString
        pendingPages.insert(pageID)
        
        api.getUsersList(
            cursor: listState.cursor,
            limit: Constants.UserList.pageSize,
            skipCache: skipCache) { [weak self] result in
                
                guard let strongSelf = self, strongSelf.pendingPages.contains(pageID) else { return }
                
                if let response = result.value {
                    let page = Page(uid: pageID, response: response)
                    strongSelf.addUniquePage(page)
                    completion(.success(strongSelf.listState.items))
                } else {
                    completion(.failure(result.error ?? APIError.unknown))
                }
                
                strongSelf.isLoadingList = false
        }
    }
    
    private func addUniquePage(_ page: Page) {
        queue.sync {
            if let index = pages.index(of: page) {
                pages[index] = page
            } else {
                pages.append(page)
            }
        }
    }
}

extension UserListInteractor {
    
    struct Page: Hashable {
        let uid: String
        let response: UsersListResponse
        
        var hashValue: Int {
            return uid.hashValue
        }
        
        static func ==(lhs: Page, rhs: Page) -> Bool {
            return lhs.uid == rhs.uid
        }
    }
}
