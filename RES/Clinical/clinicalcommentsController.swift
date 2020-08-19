//
//  clinicalcommentsController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import FirebaseDatabase
import MessageUI

public func performSubmission(vc: UIViewController, completion: ()->()) {
    let alert = UIAlertController(title: "Evaluation Submitted", message: "Congratulations on submitting an evaluation!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak vc] (_) in
        
  
    vc?.navigationController?.performSegue(withIdentifier: "facultySegue", sender: vc)
    }))
    
    
    let defaults = UserDefaults.standard
    let count: Int = defaults.value(forKey: "BadgeCount") as! Int
    UIApplication.shared.applicationIconBadgeNumber = (count - 1)
    vc.present(alert, animated: true)
}

public func performSubmissionWithEmail(vc: UIViewController, attendeeName: String, date: String, completion: ()->()) {
    
    let defaults = UserDefaults.standard
    let count: Int = defaults.value(forKey: "BadgeCount") as! Int
    UIApplication.shared.applicationIconBadgeNumber = (count - 1)
 
    let emailTitle = "Reccommending remediation for \(attendeeName)"
    let messageBody = "Reccommended remediation for \(attendeeName) prompted by evaluation grade given on date \(date) which was unsatisfactory"
    let toRecipents = ["rgriffincook@yahoo.com", "drheathg@gmail.com"]
//    let toRecipents = ["rgriffincook@yahoo.com"]
    let mc: MFMailComposeViewController = MFMailComposeViewController()
    
    mc.mailComposeDelegate = vc as? MFMailComposeViewControllerDelegate
    mc.setSubject(emailTitle)
    mc.setMessageBody(messageBody, isHTML: false)
    mc.setToRecipients(toRecipents)
    
    vc.navigationController?.present(mc, animated: true, completion: {
        vc.navigationController?.performSegue(withIdentifier: "facultySegue", sender: vc)
    })
    
}

class clinicalcommentsController: UIViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate{
    
    let ref = Database.database().reference()

    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var textField: UITextView! {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBarSetup(title: "Comment & Submit")
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @objc func popController(){
        self.navigationController?.performSegue(withIdentifier: "clin11", sender: self)
//        self.navigationController?.popViewController(animated: true)
        ApplicationState.sharedState.LoggedIn = false
    }
    
    @objc func logoutNow(){
        wipeMemory()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        gradingClinicalData.shared.additionalComments = textField.text
        
        guard let attendeeName = gradingClinicalData.shared.attendeeName else {return}
        guard let setting = gradingClinicalData.shared.setting else {return}
        guard let date = gradingClinicalData.shared.date else {return}
        guard let timing = gradingClinicalData.shared.timing else {return}
        guard let attire = gradingClinicalData.shared.attire else {return}
        guard let history = gradingClinicalData.shared.history else {return}
        guard let physicalExam = gradingClinicalData.shared.physicalExam else {return}
        guard let plan = gradingClinicalData.shared.plan else {return}
        guard let diagnosis = gradingClinicalData.shared.diagnosis else {return}
        guard let presentation = gradingClinicalData.shared.presentation else {return}
        guard let score = gradingClinicalData.shared.score else {return}
        guard let evalType = gradingClinicalData.shared.evalType else {return}
        
        guard let username = evaluationData.shared.userName else {return}
        
        if let state = ApplicationState.sharedState.isOnUnpromptedPath {
            if state == true {
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("attendeeName").setValue(username)
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("date").setValue(date)
           }
        }
        
        self.ref.child("Residents/\(attendeeName)").child("Graded Evaluations").child(date).updateChildValues(["graded": "true", "physicalExam": physicalExam, "date":date, "setting":setting, "timing":timing, "attire":attire, "history":history, "plan":plan,"diagnosis":diagnosis,"presentation":presentation,"score":score,"evalType":evalType,"comments":textField.text as String, "FacultyName": username])
        
        if let selectedEval = gradingTechnicalData.shared.selectedEvalDate {
            
            self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(String(selectedEval)).removeValue()
            performSubmission(vc: self){
            wipeClinicalMemory()
            }
        } else {
            performSubmission(vc: self){
            wipeClinicalMemory()
            }
        }
    }

    @IBAction func finishWithRemediation(_ sender: Any) {
        gradingClinicalData.shared.additionalComments = textField.text
          
        guard let attendeeName = gradingClinicalData.shared.attendeeName else {return}
        guard let setting = gradingClinicalData.shared.setting else {return}
        guard let date = gradingClinicalData.shared.date else {return}
        guard let timing = gradingClinicalData.shared.timing else {return}
        guard let attire = gradingClinicalData.shared.attire else {return}
        guard let history = gradingClinicalData.shared.history else {return}
        guard let physicalExam = gradingClinicalData.shared.physicalExam else {return}
        guard let plan = gradingClinicalData.shared.plan else {return}
        guard let diagnosis = gradingClinicalData.shared.diagnosis else {return}
        guard let presentation = gradingClinicalData.shared.presentation else {return}
        guard let score = gradingClinicalData.shared.score else {return}
        guard let evalType = gradingClinicalData.shared.evalType else {return}
        
        guard let username = evaluationData.shared.userName else {return}
        
        if let state = ApplicationState.sharedState.isOnUnpromptedPath {
            if state == true {
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("attendeeName").setValue(username)
            self.ref.child("Residents/\(String(describing: attendeeName))").child("Requested Evaluations").child(date).child("date").setValue(date)
           }
        }
          
        self.ref.child("Residents/\(attendeeName)").child("Graded Evaluations").child(date).updateChildValues(["graded": "true", "physicalExam": physicalExam, "date":date, "setting":setting, "timing":timing, "attire":attire, "history":history, "plan":plan,"diagnosis":diagnosis,"presentation":presentation,"score":score,"evalType":evalType,"comments":textField.text as String])
           
           if let selectedEval = gradingTechnicalData.shared.selectedEvalDate {

           self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(String(selectedEval)).removeValue()
            
            performSubmissionWithEmail(vc: self, attendeeName: attendeeName, date: date) {
            wipeClinicalMemory()
            }
            } else {
            performSubmissionWithEmail(vc: self, attendeeName: attendeeName, date: date) {
            wipeClinicalMemory()
            }
        }
    


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueHelper(nextVC: clinicalScoreController())
    }
    
}
