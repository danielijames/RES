//
//  loginViewController.swift
//  RES
//
//  Created by Daniel James on 10/18/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class loginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var usernameBox: UITextField!
    @IBOutlet weak var loginBox: UITextField!
    
    var typeOfUser = ""
    let defaults = UserDefaults.standard
    let firebaseFunction = firebaseFunctions()
    var loginInfoStudent = [(username: String, password: Any)]()
    var loginInfoFaculty = [(username: String, password: Any)]()
    
    @IBAction func loginButton(_ sender: Any) {
        guard let username = self.usernameBox.text else {return}
        guard let password = self.loginBox.text else {return}
        
        switch self.typeOfUser {
        case "Student":
            for name in self.loginInfoStudent where name.username == username && "\(String(describing: name.password))" == password {
                evaluationData.shared.userName = username
                performSegue(withIdentifier: "studentSegue", sender: self)
                ApplicationState.sharedState.LoggedIn = true
            }
        //
        default:
            for name in self.loginInfoFaculty where name.username == username && "\(String(describing: name.password))" == password {
                evaluationData.shared.userName = username
                performSegue(withIdentifier: "facultySegue", sender: self)
                ApplicationState.sharedState.LoggedIn = true
            }
        }
    }
    
    
    @IBAction func segmentedController(_ sender: Any) {
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("override view did load")
        self.retrieveData(path: "Residents")
        self.retrieveDataFaculty(path: "Faculty")
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.Login.layer.cornerRadius = 10
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func retrieveData(path: String) {
        let ref = Database.database().reference()
        
        DispatchQueue.main.async {
            ref.child(path).observe(.value) { (data) in
                guard let value = data.value as? [String: Dictionary<String, Any>] else { return }
                for each in value {
                    guard let password = each.value["Password"] else {return}
                    self.loginInfoStudent.append((username: each.key, password: password))
                }
            }
        }
    }
    
    func retrieveDataFaculty(path: String) {
        let ref = Database.database().reference()
        
        DispatchQueue.main.async {
            ref.child(path).observe(.value) { (data) in
                guard let value = data.value as? [String: Dictionary<String, Any>] else { return }
                
                for each in value {
                    guard let password = each.value["Password"] else {return}
                    self.loginInfoFaculty.append((username: each.key, password: password))
                    //                    print(self.loginInfoFaculty)
                }
            }
            
        }
        
    }
    
}
