//
//  CommentRepliesCommentRepliesPresenterTests.swift
//  EmbeddedSocial-Framework
//
//  Created by generamba setup on 14/08/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import XCTest

class CommentRepliesPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: CommentRepliesInteractorInput {

    }

    class MockRouter: CommentRepliesRouterInput {

    }

    class MockViewController: CommentRepliesViewInput {

        func setupInitialState() {

        }
    }
}