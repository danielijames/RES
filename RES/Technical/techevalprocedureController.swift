//
//  techevalprocedureController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techevalprocedureController: UIViewController, ViewDelegate {
    
    let screenView = VariadicView()
    
    
    override func loadView() {
        view = screenView
    }
    
    
    var Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Operation")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "Procedure")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        switch ApplicationState.sharedState.isOnUnpromptedPath {
        case true:
            self.navigationController?.performSegue(withIdentifier: "tech1", sender: self)
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
        return "Which Procedure?"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {
        gradingTechnicalData.shared.procedure = Array[indexPath.row]
        
        if ApplicationState.sharedState.isOnUnpromptedPath == true {
        self.navigationController?.performSegue(withIdentifier: "tech3", sender: self)} else {
           self.navigationController?.performSegue(withIdentifier: "tech4", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch ApplicationState.sharedState.isOnUnpromptedPath {
        case true:
            segueHelper(nextVC: techdateSelectorView())
        default:
            segueHelper(nextVC: techcasedifficultyController())
        }
    }
}
