//
//  techcommentsController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techcommentsController: UIViewController {
    
    let ref = Database.database().reference()
    @IBOutlet weak var commentsText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        
        guard let username = evaluationData.shared.userName else {return}
        evaluationData.additionalComments = commentsText.text
        evaluationData.graded = true
        
        self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(evaluationData.selectedEval.student!).removeValue()
        self.ref.child("Faculty/\(username)").child("Graded Requests").child(evaluationData.selectedEval.student!).setValue(evaluationData.selectedEval.date)
        
        evaluationData.evalSet[1].append(evaluationData.selectedEval as! (student: String, date: String))
        
        evaluationData.evalSet[0].removeAll { (deletionTuple) -> Bool in
            if deletionTuple == evaluationData.selectedEval {
                return true
            }
        return false}
        
        
        let alert = UIAlertController(title: "Evaluation Submitted", message: "Verify you have submitted a request by navigating back to the filter screen and notice that the evaluation is now located in the graded section.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "techHome", sender: self)
        }))

        self.present(alert, animated: true)
    
    }
    

}
