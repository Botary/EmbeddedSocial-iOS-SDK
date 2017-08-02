//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import XCTest
@testable import EmbeddedSocial

class MockPostService: PostServiceProtocol {
    
    var fetchPopularIsCalled = false
    var fetchPopularQuery: PopularFeedQuery?
    
    var fetchRecentIsCalled = false
    var fetchRecentQuery: RecentFeedQuery?
    
    var fetchRecentForUserIsCalled = false
    var fetchRecentForUserQuery: UserFeedQuery?
    
    var fetchPopularForUserIsCalled = false
    var fetchPopularForUserQuery: UserFeedQuery?
    
    var fetchPostIsCalled = false
    var fetchPostHandle: PostHandle?
    
    func fetchPopular(query: PopularFeedQuery, completion: @escaping FetchResultHandler) {
        fetchPopularIsCalled = true
        fetchPopularQuery = query
    }
    
    func fetchRecent(query: RecentFeedQuery, completion: @escaping FetchResultHandler) {
        fetchRecentIsCalled = true
        fetchRecentQuery = query
    }
    
    func fetchRecent(query: UserFeedQuery, completion: @escaping FetchResultHandler) {
        fetchRecentForUserIsCalled = true
        fetchRecentForUserQuery = query
    }
    
    func fetchPopular(query: UserFeedQuery, completion: @escaping FetchResultHandler) {
        fetchPopularForUserIsCalled = true
        fetchPopularForUserQuery = query
    }
    
    func fetchPost(post: PostHandle, completion: @escaping FetchResultHandler) {
        fetchPostIsCalled = true
        fetchPostHandle = post
    }
}

class FeedModuleInteractorTests: XCTestCase {
    
    var sut: FeedModuleInteractor!
    var postService: MockPostService!
    
    override func setUp() {
        super.setUp()
        
        sut = FeedModuleInteractor()
        postService = MockPostService()
        sut.postService = postService

    }
    
    func testThatHomeFeedFetchRequestIsValid() {
        
        // given
        let feedType = FeedType.home
        
        // when
        sut.fetchPosts(feedType: feedType)
        
        // then
        XCTAssertTrue(postService.fetchRecentIsCalled)
        sut.fetchPosts(limit: 20, cursor: "20", type: feedType)
        
        // then
        XCTAssertTrue(postService.fetchRecentIsCalled)
        XCTAssertTrue(postService.fetchRecentQuery!.cursor == "20")
        XCTAssertTrue(postService.fetchRecentQuery!.limit == 20)
    }
    
    func testThatPopularFeedFetchRequestIsValid() {
        
        // given
        let feedType = FeedType.popular(type: .today)
        
        // when
        sut.fetchPosts(feedType: feedType)
        
        // then
        XCTAssertTrue(postService.fetchPopularIsCalled)
        XCTAssertTrue(postService.fetchPopularQuery!.timeRange == .today )
    }
    
    func testThatSinglePostFetchFeedRequestIsValid() {
        
        // given
        let feedType = FeedType.single(post: "handle")
        
        // when
        sut.fetchPosts(feedType: feedType)
        
        // then
        XCTAssertTrue(postService.fetchPostHandle == "handle")
    }
    
    func testThatUserFeedFetchRequestIsValid() {
        
        // given
        let feedType = FeedType.user(user: "user", scope: .recent)
        
        // when
        sut.fetchPosts(limit: 20, cursor: "20", type: feedType)
        
        // then
        XCTAssertTrue(postService.fetchRecentForUserIsCalled)
        XCTAssertTrue(postService.fetchRecentForUserQuery!.cursor == "20")
        XCTAssertTrue(postService.fetchRecentForUserQuery!.limit == 20)
        XCTAssertTrue(postService.fetchRecentForUserQuery!.user == "user")
    }
    
}