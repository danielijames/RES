//
//  clinicalScoreController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class clinicalScoreController: UIViewController, ViewDelegate {
    
    let screenView = VariadicView()
    
    override func loadView() {
        view = screenView
    }
    
    var Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Clinical/Score")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "Score")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        self.navigationController?.performSegue(withIdentifier: "clin10", sender: self)
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
                self.Array.append(String(each.key))
            }
            self.screenView.table.reloadData()
        }
    }
    
    func getTitle() -> String! {
        return "Select Score"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {
        gradingClinicalData.shared.score = Array[indexPath.row]
        self.navigationController?.performSegue(withIdentifier: "clin12", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "clin10":
            segueHelper(nextVC: clinicalPresentationController())
        default:
            segueHelper(nextVC: clinicalcommentsController())
        }
        
    }
}
