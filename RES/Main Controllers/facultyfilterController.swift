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
        self.navigationController?.pushViewController(techevalResidentsController(), animated: true)
        gradingTechnicalData.shared.evalType = "Technical"
    }
    
    @IBAction func clinicalSegue(_ sender: Any) {
        self.navigationController?.pushViewController(clinicalevalResidentsController(), animated: true)
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
                self.navigationController?.popViewController(animated: true)
                ApplicationState.sharedState.LoggedIn = false
            }
        
        @objc func logoutNow(){
            wipeMemory()
            self.navigationController?.popToRootViewController(animated: true)
        }
}
