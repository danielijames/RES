//
//  techevalResidentsController.swift
//  RES
//
//  Created by Daniel James on 12/12/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techevalResidentsController: UIViewController, ViewDelegate {
    
    let screenView = VariadicView()
    
    
    override func loadView() {
        view = screenView
    }
    
    
    var Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Residents")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "Pick Resident")
        
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
        return "For which Resident?"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {
        gradingTechnicalData.shared.attendeeName = Array[indexPath.row]
        self.navigationController?.pushViewController(techevalprocedureController(), animated: true)
    } 
}
