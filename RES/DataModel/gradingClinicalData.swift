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
    
        //for grading evals
      var residentEvaluated: String?
      var procedureEvaluated: String?
      var facultydateselected: String?
      
      
      //criterion
      var selectedEval: (student: String?, date: String?)
      var evalType: String?
      var setting: String?
      var timing: String?
      var attire: String?
      var history: String?
      var physicalExam: String?
      var plan: String?
      var diagnosis: String?
      var presentation: String?
      var score: String?
      var areasforimprovements = Set<String?>()
      var additionalComments: String?
      var graded: Bool?
      var evalSet = [[(student: String, date: String)](),[(student: String, date: String)]()]
}
