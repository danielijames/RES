//
//  techImprovementController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase



class techImprovementController: UIViewController, ViewDelegate {
    
    let screenView = VariadicView()
    
    
    override func loadView() {
        view = screenView
    }
    
    
    var Array = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveData(path: "Technical/Improvement")
        
        screenView.delegate = self
        screenView.table.delegate = screenView
        screenView.table.dataSource = screenView
        
        navBarSetup(title: "Improvements Needed")
        
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
            
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    
    @objc func popController(){
        gradingTechnicalData.shared.improvements.removeAll()
        self.navigationController?.performSegue(withIdentifier: "tech6", sender: self)
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
    
    @IBAction func `continue`(_ sender: Any) {
       self.navigationController?.performSegue(withIdentifier: "tech9", sender: self)
    }
    
    func getTitle() -> String! {
        return "Improvements Needed"
    }
    
    func getContentArray() -> Array<String> {
        return self.Array
    }
    
    func continueToNextScreen(indexPath: IndexPath) {

        screenView.table.deselectRow(at: indexPath, animated: true)
        
        switch screenView.table.cellForRow(at: indexPath)?.accessoryType {
        case .checkmark:
            screenView.table.cellForRow(at: indexPath)?.backgroundColor = UIColor.white
            screenView.table.cellForRow(at: indexPath)?.accessoryType = .none
            screenView.table.reloadData()
            gradingTechnicalData.shared.improvements.remove(Array[indexPath.row])
        default:
            screenView.table.cellForRow(at: indexPath)?.backgroundColor = UIColor.systemYellow
            screenView.table.cellForRow(at: indexPath)?.accessoryType = .checkmark
           screenView.table.reloadData()
            gradingTechnicalData.shared.improvements.insert(Array[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
         case "tech7":
             segueHelper(nextVC: techscoreController())
         default:
             segueHelper(nextVC: techcommentsController())
         }
        
    }
}
