//
//  gradingTechnicalData.swift
//  RES
//
//  Created by Daniel James on 3/24/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation


class gradingTechnicalData {
    
    static let shared = gradingTechnicalData()
    
        //for grading evals
      var residentEvaluated: String?
      var procedureEvaluated: String?
      var facultydateselected: String?
      
      
      //criterion
      var selectedEval: (student: String?, date: String?)
      var evalType: String?
      var caseDifficulty: String?
      var preparation: String?
      var percentPerformed: String?
      var scoreGiven: String?
      var improvements = Set<String?>()
      var additionalComments: String?
      var graded: Bool?
      var evalSet = [[(student: String, date: String)](),[(student: String, date: String)]()]
}
