//
//  clinicalcommentsController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import FirebaseDatabase

class clinicalcommentsController: UIViewController {
    
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
        
        guard let username = evaluationData.shared.userName else {return}
        gradingTechnicalData.shared.additionalComments = commentsText.text
        gradingTechnicalData.shared.graded = true
        
        self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(gradingTechnicalData.shared.selectedEval.student!).removeValue()
        self.ref.child("Faculty/\(username)").child("Graded Requests").child(gradingTechnicalData.shared.selectedEval.student!).setValue(gradingTechnicalData.shared.selectedEval.date)
        
        gradingTechnicalData.shared.evalSet[1].append(gradingTechnicalData.shared.selectedEval as! (student: String, date: String))
        
        gradingTechnicalData.shared.evalSet[0].removeAll { (deletionTuple) -> Bool in
            if deletionTuple == gradingTechnicalData.shared.selectedEval {
                return true
            }
            return false}
        
        
        let alert = UIAlertController(title: "Evaluation Submitted", message: "Verify you have submitted a request by navigating back to the filter screen and notice that the evaluation is now located in the graded section.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] (_) in
            
            self?.navigationController?.popToViewController((self?.navigationController?.viewControllers[1])!, animated: true)
            //            self?.performSegue(withIdentifier: "techHome", sender: self)
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func finishWithRemediation(_ sender: Any) {
        
        guard let username = evaluationData.shared.userName else {return}
        gradingTechnicalData.shared.additionalComments = commentsText.text
        gradingTechnicalData.shared.graded = true
        
        self.ref.child("Faculty/\(username)").child("Ungraded Requests").child(gradingTechnicalData.shared.selectedEval.student!).removeValue()
        self.ref.child("Faculty/\(username)").child("Graded Requests").child(gradingTechnicalData.shared.selectedEval.student!).setValue(gradingTechnicalData.shared.selectedEval.date)
        
        gradingTechnicalData.shared.evalSet[1].append(gradingTechnicalData.shared.selectedEval as! (student: String, date: String))
        
        gradingTechnicalData.shared.evalSet[0].removeAll { (deletionTuple) -> Bool in
            if deletionTuple == gradingTechnicalData.shared.selectedEval {
                return true
            }
            return false}
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        
        
        let email = "rgriffincook@yahoo.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
