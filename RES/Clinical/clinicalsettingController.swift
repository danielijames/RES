//
//  clinicalsettingController.swift
//  RES
//
//  Created by Daniel James on 3/25/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import FirebaseDatabase

class clinicalsettingController: UIViewController, ViewDelegate {
    
    let screenView = VariadicView()
    
    override func loadView() {
        view = screenView
    }
    
    var Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Clinical/setting")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "What Setting?")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        switch ApplicationState.sharedState.isOnUnpromptedPath {
        case true:
            self.navigationController?.performSegue(withIdentifier: "clin1", sender: self)
        default:
            self.navigationController?.popToRootViewController(animated: true)
        }
        
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
        return "Setting"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {
        gradingClinicalData.shared.setting = Array[indexPath.row]
        
        switch ApplicationState.sharedState.isOnUnpromptedPath {
        case true:
            self.navigationController?.performSegue(withIdentifier: "clin3", sender: self)
        default:
            self.navigationController?.performSegue(withIdentifier: "clin4", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "clin3":
            segueHelper(nextVC: clinicaldateController())
        case "clin1":
            segueHelper(nextVC: clinicalevalResidentsController())
        case "clin4":
            segueHelper(nextVC: clinicalTimelinessController())
        default:
            break
        }
        
        
    }
}
