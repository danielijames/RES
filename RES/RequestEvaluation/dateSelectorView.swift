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
        
        evaluationData.shared.date = String(dateCorrected!)
        
       let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "StudentfinalSubmit")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
