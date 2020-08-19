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

class techcommentsController: UIViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var textField: UITextView!{
            didSet{
                let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: 200, height: 40)))
                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let doneBtn = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dismissKeyboard))
                toolbar.setItems([flexSpace, doneBtn], animated: true)
                    
                
                textField.layer.borderWidth = 2.5
                textField.layer.borderColor = UIColor.black.cgColor
                textField.layer.cornerRadius = 7.5
                textField.inputAccessoryView = toolbar
            }
        }

        @objc func dismissKeyboard(){
            self.view.endEditing(true)
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
                    UIView.animate(withDuration: 0.3) {
                        self.textField.frame.origin.y = 20
                        self.helpLabel.isHidden = true
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            self.helpLabel.isHidden = false
            self.textField.frame.origin.y = 200
        }
    let ref = Database.database().reference()

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
        
        gradingTechnicalData.shared.additionalComments = textField.text
        
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
        
        
        if let state = ApplicationState.sharedState.isOnUnpromptedPath {
            if state == true {
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("attendeeName").setValue(username)
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("date").setValue(date)
           }
        }
        
        
        self.ref.child("Residents/\(attendeeName)").child("Graded Evaluations").child(date).updateChildValues(["graded": "true", "procedure": procedure, "date":date, "caseDifficulty":caseDifficulty, "preparation":preparation, "percent":percent, "score":score, "improvements":improvements, "comments":comments,"evalType": evalType, "FacultyName": username])
        
        if let selectedEval = gradingTechnicalData.shared.selectedEvalDate {
            
            self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(String(selectedEval)).removeValue()
            performSubmission(vc: self){
            wipeTechnicalMemory()
            }
        } else {
            performSubmission(vc: self){
            wipeTechnicalMemory()
            }
        }
        
    }
    
    @IBAction func finishWithRemediation(_ sender: Any) {
        gradingTechnicalData.shared.additionalComments = textField.text
        
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
        
        if let state = ApplicationState.sharedState.isOnUnpromptedPath {
            if state == true {
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("attendeeName").setValue(username)
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("date").setValue(date)
           }
        }
        
        self.ref.child("Residents/\(attendeeName)").child("Graded Evaluations").child(date).updateChildValues(["graded": "true", "procedure": procedure, "date":date, "caseDifficulty":caseDifficulty, "preparation":preparation, "percent":percent, "score":score, "improvements":improvements, "comments":comments])
        
        
        if let selectedEval = gradingTechnicalData.shared.selectedEvalDate {
            
            self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(String(selectedEval)).removeValue()
            
            performSubmissionWithEmail(vc: self, attendeeName: attendeeName, date: date){
            wipeTechnicalMemory()
            }
        } else {
            performSubmissionWithEmail(vc: self, attendeeName: attendeeName, date: date){
            wipeTechnicalMemory()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueHelper(nextVC: techImprovementController())
    }
    
}
