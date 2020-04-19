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
      var improvements = Set<String?>()
      var additionalComments: String?
    
      var receivedData: [JSONData]?
      var selectedEvalDate: String?
      var combinedKeywithData = [[String:JSONData]]()
}
