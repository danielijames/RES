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
    
    //the username you signed in with
    var userName: String?
    
    //student request flow
    var attendeeName: String?
    var procedure: String?
    var date: String?
    var graded: String?

    //tableView consume data
    var pendingGrades: [Any]?
}

