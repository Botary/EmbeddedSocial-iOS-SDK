//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit

enum RepliesScrollType {
    case none
    case bottom
}

class CommentRepliesModuleConfigurator {

    let viewController: CommentRepliesViewController
    
    init() {
        viewController = StoryboardScene.CommentReplies.instantiateCommentRepliesViewController()
    }
    
    func configure(commentView: CommentViewModel,
                   scrollType: RepliesScrollType,
                   postDetailsPresenter: PostDetailPresenter?,
                   isAnonymous: Bool = SocialPlus.shared.me == nil,
                   loginOpener: LoginModalOpener? = SocialPlus.shared.coordinator) {

        let router = CommentRepliesRouter()
        router.loginOpener = loginOpener
        
        let repliesService = RepliesService()

        let presenter = CommentRepliesPresenter(isAnonymous: isAnonymous)
        presenter.view = viewController
        presenter.router = router
        presenter.commentView = commentView
        presenter.scrollType = scrollType
        let interactor = CommentRepliesInteractor()
        interactor.output = presenter

        let likeService = LikesService()
        interactor.likeService = likeService
        
        presenter.interactor = interactor
        interactor.repliesService = repliesService
        viewController.output = presenter
        
        postDetailsPresenter?.repliesPresenter = presenter
    }

}
