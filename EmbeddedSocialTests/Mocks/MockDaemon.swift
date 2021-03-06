//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

@testable import EmbeddedSocial

class MockDaemon: Daemon {
    
    //MARK: - start
    
    var startCalled = false
    
    func start() {
        startCalled = true
    }
    
    //MARK: - stop
    
    var stopCalled = false
    
    func stop() {
        stopCalled = true
    }
    
}
