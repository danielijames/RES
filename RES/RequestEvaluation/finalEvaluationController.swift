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
    @IBOutlet weak var submittalButton: UIButton! {
        didSet {
            submittalButton.layer.cornerRadius = 10
        }
    }
    var username: String!
    var procedure: String!
    var attendeeName: String!
    var date: String?
    
    let ref = Database.database().reference()
    
    func changeSubmittalText(){
        guard let username = evaluationData.shared.userName else {return}
        guard let procedure = evaluationData.shared.procedure else {return}
        guard let attendeeName = evaluationData.shared.attendeeName else {return}
        guard let date = evaluationData.shared.date else {return}
        self.date = date

        
        submittalText.text = "\(username) requesting an evaluation for \(procedure) from \(attendeeName) on \(date)."
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.additionalSafeAreaInsets = .init(top: 30, left: 0, bottom: 0, right: 0)
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
        })
        
        self.changeSubmittalText()
    }
    
    @objc func logoutNow(){
        wipeMemory()
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func finalSubmittal(_ sender: Any) {
        if let username = self.username, let attendeeName = self.attendeeName, let date = self.date, let procedure = self.procedure {

            let key = date + "from" + username
            
        self.ref.child("Residents/\(String(describing: username))").child("Requested Evaluations").child(date).setValue(attendeeName)
             
             self.ref.child("Faculty/\(String(describing: attendeeName))").child("Ungraded Requests").child(key).setValue(procedure)
        
             let alert = UIAlertController(title: "Request Submitted", message: "Verify you have submitted a request by navigating to the review graded evaluations tab and reviewing your submitted evaluations.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                 self.performSegue(withIdentifier: "filterViewFromRequestEval", sender: nil)
             }))

             self.present(alert, animated: true)
            
        }
    }
}
