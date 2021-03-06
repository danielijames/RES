//
//  dateSelectorView.swift
//  RES
//
//  Created by Daniel James on 11/27/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class dateSelectorView: UIViewController {
    @IBOutlet weak var dateButton: UIButton!
    
    var date: String?
    
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet{
            datePicker.timeZone = TimeZone(abbreviation: "GMT")
            datePicker.calendar = .autoupdatingCurrent
            datePicker.datePickerMode = .dateAndTime
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.date = datePicker.date.description
        navBarSetup(title: "Date of Procedure")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    @objc func popController(){
        self.navigationController?.performSegue(withIdentifier: "request2", sender: self)
//        self.navigationController?.popViewController(animated: true)
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
        datePicker.timeZone = TimeZone(abbreviation: "GMT")
        let dateCorrected = self.date?.prefix(19)
        
        evaluationData.shared.date = String(dateCorrected!)
             
        self.navigationController?.performSegue(withIdentifier: "request4", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "request2" {
            segueHelper(nextVC: procedureController())
        }
    }
    
}
