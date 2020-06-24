//
//  MemoryCleaner.swift
//  RES
//
//  Created by Daniel James on 3/22/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func wipeMemory(){
        evaluationData.shared.userName = nil
        evaluationData.shared.procedure = nil
        evaluationData.shared.attendeeName = nil
        evaluationData.shared.date = nil
    }
    
    func wipeTechnicalMemory(){
        gradingTechnicalData.shared.additionalComments = nil
        gradingTechnicalData.shared.caseDifficulty = nil
        gradingTechnicalData.shared.date = nil
        gradingTechnicalData.shared.evalType = nil
        gradingTechnicalData.shared.graded = nil
        gradingTechnicalData.shared.improvements = [""]
        gradingTechnicalData.shared.percentPerformed = nil
        gradingTechnicalData.shared.preparation = nil
        gradingTechnicalData.shared.procedure = nil
        gradingTechnicalData.shared.scoreGiven = nil
    }
    
    func wipeClinicalMemory(){
        gradingClinicalData.shared.additionalComments = nil
        gradingClinicalData.shared.attire = nil
        gradingClinicalData.shared.date = nil
        gradingClinicalData.shared.diagnosis = nil
        gradingClinicalData.shared.history = nil
        gradingClinicalData.shared.physicalExam = nil
        gradingClinicalData.shared.plan = nil
        gradingClinicalData.shared.presentation = nil
        gradingClinicalData.shared.score = nil
        gradingClinicalData.shared.setting = nil
        gradingClinicalData.shared.timing = nil
        
        
    }
}


