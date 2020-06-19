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
    var graded: String?
    
    let ref = Database.database().reference()
    
    func changeSubmittalText(){
        guard let username = evaluationData.shared.userName else {return}
        guard let procedure = evaluationData.shared.procedure else {return}
        guard let attendeeName = evaluationData.shared.attendeeName else {return}
        guard let date = evaluationData.shared.date else {return}
        self.date = date
        self.username = username
        self.procedure = procedure
        self.attendeeName = attendeeName
        self.graded = "false"
        
        submittalText.text = "\(username) requesting an evaluation for \(procedure) from \(attendeeName) on \(date)."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeSubmittalText()
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
        })
        
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        self.navigationController?.popViewController(animated: true)
        ApplicationState.sharedState.LoggedIn = false
    }
    
    @objc func logoutNow(){
        wipeMemory()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func finalSubmittal(_ sender: Any) {
        if let username = self.username, let attendeeName = self.attendeeName, let date = self.date, let procedure = self.procedure {
            
//            let key = date + "from" + username
//            
            
            self.ref.child("Residents/\(String(describing: username))").child("Requested Evaluations").child(date).child("attendeeName").setValue(attendeeName)
            self.ref.child("Residents/\(String(describing: username))").child("Requested Evaluations").child(date).child("date").setValue(date)
            
            
            self.ref.child("Faculty/\(String(describing: attendeeName))").child("Ungraded Requests").child(date).child("attendeeName").setValue(username)
            self.ref.child("Faculty/\(String(describing: attendeeName))").child("Ungraded Requests").child(date).child("date").setValue(date)
            self.ref.child("Faculty/\(String(describing: attendeeName))").child("Ungraded Requests").child(date).child("procedure").setValue(procedure)
            
            
            
            let alert = UIAlertController(title: "Request Submitted", message: "Verify you have submitted a request by navigating to the review graded evaluations tab and reviewing your submitted evaluations.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                    
                self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
            }))
            
            self.present(alert, animated: true)
            
        }
    }
}
