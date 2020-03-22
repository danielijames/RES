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
    
    //for grading evals
    static var residentEvaluated: String?
    static var procedureEvaluated: String?
    static var facultydateselected: String?
    
    
    //criterion
    static var selectedEval: (student: String?, date: String?)
    static var caseDifficulty: String?
    static var preparation: String?
    static var percentPerformed: String?
    static var scoreGiven: String?
    static var improvements = [String?]()
    static var additionalComments: String?
    static var graded: Bool?
    static var evalSet = [[(student: String, date: String)](),[(student: String, date: String)]()]
  
    

}
