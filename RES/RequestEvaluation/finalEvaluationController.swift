//
//  finalEvaluationController.swift
//  RES
//
//  Created by Daniel James on 11/27/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class finalEvaluationController: UIViewController {

    @IBOutlet weak var submittalText: UILabel!
    @IBOutlet weak var submittalButton: UIButton!
    
    let ref = Database.database().reference()
    let defaults = UserDefaults.standard
    var date: String?
    
    func changeSubmittalText(){
        guard let username = evaluationData.userName else {return}
        guard let procedure = evaluationData.procedure else {return}
        guard let attendeeName = evaluationData.attendeeName else {return}
        guard let date = evaluationData.date else {return}
        self.date = date

        
        submittalText.text = "\(username) requesting an evaluation for \(procedure) from \(attendeeName) on \(date)."
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeSubmittalText()
        self.submittalButton.layer.cornerRadius = 10
    }
    
    @IBAction func finalSubmittal(_ sender: Any) {
        guard let username = evaluationData.userName else {return}
        guard let attendeeName = evaluationData.attendeeName else {return}
        guard let date = evaluationData.date else {return}
        guard let procedure = evaluationData.procedure else {return}
        let key = date + " from " + username
       
        self.ref.child("Residents/\(username)").child("Requested Evaluations").child(date).setValue(attendeeName)
        
        self.ref.child("Faculty/\(String(describing: attendeeName))").child("Ungraded Requests").child(key).setValue(procedure)
   
        let alert = UIAlertController(title: "Request Submitted", message: "Verify you have submitted a request by navigating to the review graded evaluations tab and reviewing your submitted evaluations.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "filterViewFromRequestEval", sender: nil)
        }))

        self.present(alert, animated: true)
    }
}
