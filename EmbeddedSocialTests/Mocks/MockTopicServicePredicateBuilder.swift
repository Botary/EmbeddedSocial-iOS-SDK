//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

@testable import EmbeddedSocial

class MockTopicServicePredicateBuilder: TopicsFeedProcessorPredicateBuilder {
    
    //MARK: - allTopicActionCommands
    
    var allTopicActionCommandsCalled = false
    var allTopicActionCommandsReturnValue: NSPredicate!
    
    func allTopicActionCommands() -> NSPredicate {
        allTopicActionCommandsCalled = true
        return allTopicActionCommandsReturnValue
    }
    
    //MARK: - allTopicCommands
    
    var allTopicCommandsCalled = false
    var allTopicCommandsReturnValue: NSPredicate!
    
    func allTopicCommands() -> NSPredicate {
        allTopicCommandsCalled = true
        return allTopicCommandsReturnValue
    }
    
    //MARK: - topicActionsRemovedTopicsCreatedComments
    
    var topicActionsRemovedTopicsCreatedCommentsCalled = false
    var topicActionsRemovedTopicsCreatedCommentsReturnValue: NSPredicate!
    
    func topicActionsRemovedTopicsCreatedComments() -> NSPredicate {
        topicActionsRemovedTopicsCreatedCommentsCalled = true
        return topicActionsRemovedTopicsCreatedCommentsReturnValue
    }
    
    //MARK: - allTopicCommandsAndAllCreatedComments
    
    var allTopicCommandsAndAllCreatedCommentsCalled = false
    var allTopicCommandsAndAllCreatedCommentsReturnValue: NSPredicate!
    
    func allTopicCommandsAndAllCreatedComments() -> NSPredicate {
        allTopicCommandsAndAllCreatedCommentsCalled = true
        return allTopicCommandsAndAllCreatedCommentsReturnValue
    }
    
}
