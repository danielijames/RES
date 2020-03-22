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
}


