//
//  techcommentsController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class techcommentsController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let ref = Database.database().reference()
    @IBOutlet weak var commentsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup(title: "Comment & Submit")
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
    
    @IBAction func submitAction(_ sender: Any) {
       gradingTechnicalData.shared.additionalComments = commentsText.text
       
       guard let attendeeName = gradingTechnicalData.shared.attendeeName else {return}
       guard let procedure = gradingTechnicalData.shared.procedure else {return}
       guard let date = gradingTechnicalData.shared.date else {return}
       guard let caseDifficulty = gradingTechnicalData.shared.caseDifficulty else {return}
       guard let preparation = gradingTechnicalData.shared.preparation else {return}
       guard let percent = gradingTechnicalData.shared.percentPerformed else {return}
       guard let score = gradingTechnicalData.shared.scoreGiven else {return}
       let improvements = Array(gradingTechnicalData.shared.improvements)
       guard let comments = gradingTechnicalData.shared.additionalComments else {return}
       guard let username = evaluationData.shared.userName else {return}
       guard let evalType = gradingTechnicalData.shared.evalType else {return}
       

        self.ref.child("Residents/\(attendeeName)").child("Graded Evaluations").child(date).updateChildValues(["graded": "true", "procedure": procedure, "date":date, "caseDifficulty":caseDifficulty, "preparation":preparation, "percent":percent, "score":score, "improvements":improvements, "comments":comments,"evalType": evalType, "FacultyName": username])
        
        guard let selectedEval = gradingTechnicalData.shared.selectedEvalDate else {return}

        self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(String(selectedEval)).removeValue()
     
        
        let alert = UIAlertController(title: "Evaluation Submitted", message: "Congratulations on submitting an evaluation!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] (_) in
           
        gradingTechnicalData.shared.improvements.removeAll()
        self?.navigationController?.popToViewController((self?.navigationController?.viewControllers[1])!, animated: true)
        }))
        
        let defaults = UserDefaults.standard
        let count: Int = defaults.value(forKey: "BadgeCount") as! Int
        UIApplication.shared.applicationIconBadgeNumber = (count - 1)
        self.present(alert, animated: true)
    
    }
    
    @IBAction func finishWithRemediation(_ sender: Any) {
            gradingTechnicalData.shared.additionalComments = commentsText.text
          
          guard let attendeeName = gradingTechnicalData.shared.attendeeName else {return}
          guard let procedure = gradingTechnicalData.shared.procedure else {return}
          guard let date = gradingTechnicalData.shared.date else {return}
          guard let caseDifficulty = gradingTechnicalData.shared.caseDifficulty else {return}
          guard let preparation = gradingTechnicalData.shared.preparation else {return}
          guard let percent = gradingTechnicalData.shared.percentPerformed else {return}
          guard let score = gradingTechnicalData.shared.scoreGiven else {return}
          let improvements = Array(gradingTechnicalData.shared.improvements)
          guard let comments = gradingTechnicalData.shared.additionalComments else {return}
          guard let username = evaluationData.shared.userName else {return}
          

           self.ref.child("Residents/\(attendeeName)").child("Graded Evaluations").child(date).updateChildValues(["graded": "true", "procedure": procedure, "date":date, "caseDifficulty":caseDifficulty, "preparation":preparation, "percent":percent, "score":score, "improvements":improvements, "comments":comments])
           
           guard let selectedEval = gradingTechnicalData.shared.selectedEvalDate else {return}

           self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(String(selectedEval)).removeValue()
        
        gradingTechnicalData.shared.improvements.removeAll()
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        
        
        let emailTitle = "Reccommending remediation for \(attendeeName)"
        let messageBody = "Reccommended remediation for \(attendeeName) prompteed by \(procedure) performance which was unsatisfactory"
        let toRecipents = ["rgriffincook@yahoo.com, drheathg@gmail.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)

        self.present(mc, animated: true, completion: nil)
//
//        let emailOne = "rgriffincook@yahoo.com"
//        if let url = URL(string: "mailto:\(emailOne)") {
//          if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url)
//          } else {
//            UIApplication.shared.openURL(url)
//          }
//        }
    }
}
