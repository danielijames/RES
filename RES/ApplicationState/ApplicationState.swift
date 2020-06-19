//
//  ApplicationState.swift
//  RES
//
//  Created by Daniel James on 3/21/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation

final class ApplicationState {
    static let sharedState = ApplicationState(LoggedIn: nil)
    
    var LoggedIn: Bool?
    var isOnUnpromptedPath: Bool?
    
    init(LoggedIn: Bool?) {
        self.LoggedIn = LoggedIn
    }
}
