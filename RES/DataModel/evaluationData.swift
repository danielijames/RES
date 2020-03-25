//
//  currentUser.swift
//  RES
//
//  Created by Daniel James on 11/3/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import Foundation

class evaluationData {
    
    static let shared = evaluationData()
    
    var userName: String?
    var attendeeName: String?
    var procedure: String?
    var date: String?
}

