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
    var AMorPM: String?

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var monthAdder: UIStepper!
    @IBOutlet weak var yearAdder: UIStepper!
    @IBOutlet weak var timeAdder: UIStepper!
    @IBOutlet weak var minuteAdder: UIStepper!
    @IBOutlet weak var pmSelector: UISegmentedControl!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayAdder: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AMorPM = pmSelector.selectedSegmentIndex == 0 ? "PM" : "AM"
        
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
    
    @IBAction func PMorAM(_ sender: Any) {
    self.AMorPM = pmSelector.selectedSegmentIndex == 0 ? "PM" : "AM"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.dateButton.layer.cornerRadius = 10
    }
    

    @IBAction func dayAdder(_ sender: Any) {
        dayAdder.maximumValue = 31
        dayAdder.stepValue = 1
        self.dayLabel.text = String(Int(dayAdder.value))
    }
    
    @IBAction func MonthAdder(_ sender: Any) {
        monthAdder.maximumValue = 12
        monthAdder.stepValue = 1
        self.monthLabel.text = String(Int(monthAdder.value))
    }
    @IBAction func yearAdder(_ sender: Any) {
       yearAdder.maximumValue = 2025
        yearAdder.minimumValue = 2020
        yearAdder.stepValue = 1
        self.yearLabel.text = String(Int(yearAdder.value))
    }
    
    @IBAction func timeAdder(_ sender: Any) {
        timeAdder.maximumValue = 12
        timeAdder.minimumValue = 1
        timeAdder.stepValue = 1
        self.timeLabel.text = String(Int(timeAdder.value))
    }
    
    @IBAction func minuteAdder(_ sender: Any) {
        minuteAdder.maximumValue = 55
        minuteAdder.minimumValue = 0
        minuteAdder.stepValue = 5
        self.minuteLabel.text = String(Int(minuteAdder.value))
    }
    

    @IBAction func finalButton(_ sender: Any) {
        let date = self.monthLabel.text! + "-" + self.dayLabel.text! + "-" + self.yearLabel.text!
         let time = "-"+self.timeLabel.text! + ":" + self.minuteLabel.text! + self.AMorPM!
         let dateFinal = date + time
        gradingClinicalData.shared.facultydateselected = dateFinal
    }
    
}
