//
//  techdateSelectorView.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class techdateSelectorView: UIViewController {
    @IBOutlet weak var dateButton: UIButton!
    
    var date: String?
    
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet{
            datePicker.calendar = .current
            datePicker.datePickerMode = .dateAndTime
            datePicker.timeZone = .current
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
        self.navigationController?.popViewController(animated: true)
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
        self.date = datePicker.date.description
        
        let dateCorrected = self.date?.prefix(19)
        
        gradingTechnicalData.shared.date = String(dateCorrected!)
        self.navigationController?.pushViewController(techcasedifficultyController(), animated: true)
    }
    
}
