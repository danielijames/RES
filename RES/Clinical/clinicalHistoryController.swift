//
//  clinicalHistoryController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class clinicalHistoryController: UIViewController, ViewDelegate {
    let screenView = VariadicView()
    
    override func loadView() {
        view = screenView
    }
    
    var Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Clinical/History")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "History")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        self.navigationController?.performSegue(withIdentifier: "clin5", sender: self)
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
            
            let values = self.sortItems(value: value)
            
            for each in values {
                self.Array.append(each.key)
            }
            self.screenView.table.reloadData()
        }
    }
    
    func getTitle() -> String! {
        return "History of Present Illness"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {
        gradingClinicalData.shared.history = Array[indexPath.row]
        self.navigationController?.performSegue(withIdentifier: "clin7", sender: self)
//        self.navigationController?.pushViewController(clinicalPhysicalExamController(), animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "clin5":
            segueHelper(nextVC: clinicalAttireController())
        default:
            segueHelper(nextVC: clinicalPhysicalExamController())
        }
    }
}
