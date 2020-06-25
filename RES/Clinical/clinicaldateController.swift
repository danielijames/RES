//
//  clinicaldateController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import UIKit

class clinicaldateController: UIViewController {
    @IBOutlet weak var dateButton: UIButton!
    
    var date: String?
 
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet{
            datePicker.calendar = .current
            datePicker.datePickerMode = .dateAndTime
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.date = datePicker.date.description
        navBarSetup(title: "Pick Date")
        
            logoutButton(vc: self, selector: #selector(logoutNow), closure: {
                ApplicationState.sharedState.LoggedIn = false
                
            })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
            }
            
            @objc func popController(){
                self.navigationController?.performSegue(withIdentifier: "clin2", sender: self)
//                self.navigationController?.popViewController(animated: true)
                ApplicationState.sharedState.LoggedIn = false
            }
        
        @objc func logoutNow(){
            wipeMemory()
            self.navigationController?.popToRootViewController(animated: true)
        }
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.dateButton.layer.cornerRadius = 10
    }
    
    @IBAction func datePicked(_ sender: Any) {
        self.date = datePicker.date.description
    }
    

    @IBAction func finalButton(_ sender: Any) {
        
        let dateCorrected = self.date?.prefix(16)
        
        gradingClinicalData.shared.date = String(dateCorrected!)
        self.navigationController?.performSegue(withIdentifier: "clin4", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "clin2":
            segueHelper(nextVC: clinicalsettingController())
        default:
            segueHelper(nextVC: clinicalTimelinessController())
        }
        
    }
    
}
