//
//  facultyfilterController.swift
//  RES
//
//  Created by Daniel James on 12/11/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class facultyfilterController: UIViewController {
    
    
    @IBOutlet weak var clinicalButton: UIButton! {
           didSet{
            clinicalButton.layer.cornerRadius = 10
           }
       }
    @IBOutlet weak var techButton: UIButton! {
        didSet{
            techButton.layer.cornerRadius = 10
        }
    }
    
    var evalData: evaluationData?
    
    @IBAction func techSegue(_ sender: Any) {
        if ApplicationState.sharedState.isOnUnpromptedPath == true {
            self.navigationController?.performSegue(withIdentifier: "tech1", sender: self)
        } else {
            self.navigationController?.performSegue(withIdentifier: "tech4", sender: self)
        }
        
        gradingTechnicalData.shared.evalType = "Technical"
    }
    
    @IBAction func clinicalSegue(_ sender: Any) {
        if ApplicationState.sharedState.isOnUnpromptedPath == true {
            self.navigationController?.performSegue(withIdentifier: "clin1", sender: self)
        } else {
            self.navigationController?.performSegue(withIdentifier: "clin2", sender: self)
        }
        
        gradingClinicalData.shared.evalType = "Clinical"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup(title: "What Type of Evaluation?")
        
            logoutButton(vc: self, selector: #selector(logoutNow), closure: {
                ApplicationState.sharedState.LoggedIn = false
                
            })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
            }
            
            @objc func popController(){
                self.navigationController?.popToRootViewController(animated: true)
//                self.navigationController?.popViewController(animated: true)
                ApplicationState.sharedState.LoggedIn = false
            }
        
        @objc func logoutNow(){
            wipeMemory()
            self.navigationController?.popToRootViewController(animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tech1" || segue.identifier == "tech4" {
            switch ApplicationState.sharedState.isOnUnpromptedPath {
            case true:
                segueHelper(nextVC: techevalResidentsController())
            default:
                segueHelper(nextVC: techcasedifficultyController())
            }
        } else {
            switch ApplicationState.sharedState.isOnUnpromptedPath {
            case true:
                segueHelper(nextVC: clinicalevalResidentsController())
            default:
                segueHelper(nextVC: clinicalsettingController())
            }
        }
    }
}
