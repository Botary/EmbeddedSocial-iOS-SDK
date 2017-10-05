//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

@testable import EmbeddedSocial

class MockAppConfiguration: AppConfigurationType {
    
    var theme: Theme = {
        let palette = ThemePalette(config: [:], accentColor: UIColor())
        return Theme(palette: palette)
    }()
    
}
