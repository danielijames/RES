//
//  gradingCriteron.swift
//  RES
//
//  Created by Daniel James on 4/18/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation

struct gradingCritereon: Decodable{
    var graded: String?
    var procedure: String?
    var attendeeName: String?
    
    
    //criterion
    var evalType: String?
    var caseDifficulty: String?
    var date: String?
    var preparation: String?
    var percentPerformed: String?
    var scoreGiven: String?
    var improvements: Set<String>?
    var additionalComments: String?
    var setting: String?
    var timing: String?
    var attire: String?
    var history: String?
    var physicalExam: String?
    var plan: String?
    var diagnosis: String?
    var presentation: String?
    var score: String?
    var FacultyName: String?
}
