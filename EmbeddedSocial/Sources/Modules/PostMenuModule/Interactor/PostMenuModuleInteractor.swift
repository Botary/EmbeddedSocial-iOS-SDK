//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

protocol PostMenuModuleInteractorInput {

    func block(user: UserHandle)
    func repost(user: UserHandle)
    func follow(user: UserHandle)
    func unfollow(user: UserHandle)
    func hide(post: PostHandle)
    func edit(post: PostHandle)
    func remove(post: PostHandle)
    
}

protocol PostMenuModuleInteractorOutput: class {
    
    func didBlock(user: UserHandle, error: Error?)
    func didRepost(user: UserHandle, error: Error?)
    func didFollow(user: UserHandle, error: Error?)
    func didUnFollow(user: UserHandle, error: Error?)
    func didHide(post: PostHandle, error: Error?)
    func didEdit(post: PostHandle, error: Error?)
    func didRemove(post: PostHandle, error: Error?)
    
}

class PostMenuModuleInteractor: PostMenuModuleInteractorInput {
    
   
    weak var output: PostMenuModuleInteractorOutput!
    var socialService: SocialServiceType!
    
    // MARK: Input
    
  
    func follow(user: UserHandle) {
     
        socialService.follow(userID: user) { [weak self] (result) in
            self?.output.didFollow(user: user, error: result.error)
        }
        
    }
    
    func unfollow(user: UserHandle) {
        
        socialService.unfollow(userID: user) { [weak self] (result) in
            self?.output.didUnFollow(user: user, error: result.error)
        }
        
    }
    
    func remove(post: PostHandle) {
        
    }
    
    func block(user: UserHandle) {
        
        socialService.block(userID: user) { [weak self] (result) in
            self?.output.didBlock(user: user, error: result.error)
        }
    }
    
    func edit(post: PostHandle) {
        
    }
    
    
    func hide(post: PostHandle) {
        
    }
    
    
    func repost(user: UserHandle) {
        
    }

}
