//
//  clinicalAttireController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class clinicalAttireController: UIViewController, ViewDelegate {
    let screenView = VariadicView()
    
    override func loadView() {
        view = screenView
    }
    
    var Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Faculty/Clinical/Attire")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "Attire")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        self.navigationController?.performSegue(withIdentifier: "clin4", sender: self)
//        self.navigationController?.popViewController(animated: true)
        ApplicationState.sharedState.LoggedIn = false
    }
    
    
    @objc func logoutNow(){
        wipeMemory()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func retrieveData(path: String) {
        let ref = Database.database().reference()
        ref.child(path).observe(.value) { (data) in
            guard let value = data.value as? [String: Any] else { return }
            
            for each in value {
                self.Array.append(each.key)
            }
            self.screenView.table.reloadData()
        }
    }
    
    func getTitle() -> String! {
        return "Select Attire"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {
        gradingClinicalData.shared.attire = Array[indexPath.row]
        self.navigationController?.performSegue(withIdentifier: "clin6", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "clin4":
            segueHelper(nextVC: clinicalTimelinessController())
        default:
            segueHelper(nextVC: clinicalHistoryController())
        }
    }
}
