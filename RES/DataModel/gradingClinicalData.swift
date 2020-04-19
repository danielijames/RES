//
//  gradingClinicalData.swift
//  RES
//
//  Created by Daniel James on 3/24/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation

class gradingClinicalData {

    static let shared = gradingClinicalData()
    
    var evalType: String?
    var attendeeName: String?
    var setting: String?
    var date: String?
    var timing: String?
    var attire: String?
    var history: String?
    var physicalExam: String?
    var plan: String?
    var diagnosis: String?
    var presentation: String?
    var score: String?
    var additionalComments: String?
}
