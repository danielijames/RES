//
//  loginViewController.swift
//  RES
//
//  Created by Daniel James on 10/18/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum retrievingDataErrors: Error {
    case failureToRecieveData
}

class loginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var usernameBox: UITextField!
    @IBOutlet weak var loginBox: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var typeOfUser = ""
    let defaults = UserDefaults.standard
    let firebaseFunction = firebaseFunctions()
    var loginInfoStudent = [(username: String, password: Any)]()
    var loginInfoFaculty = [(username: String, password: Any)]()
    let loading = loadingView()
    let ref = Database.database().reference()
    
    @IBAction func loginButton(_ sender: Any) {
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame.origin = .init(x: 0, y: 0)
        }, completion: nil)
        
        if let username = self.usernameBox.text, let password = self.loginBox.text {
      
        
        switch self.typeOfUser {
        case "Student":
            for name in self.loginInfoStudent where name.username == username && "\(String(describing: name.password))" == password {
                evaluationData.shared.userName = username
                self.navigationController?.performSegue(withIdentifier: "studentSegue", sender: self)
                ApplicationState.sharedState.LoggedIn = true
                return
            }
            errorLabel.isHidden = false
        default:
            for name in self.loginInfoFaculty where name.username == username && "\(String(describing: name.password))" == password {
                evaluationData.shared.userName = username
                self.navigationController?.performSegue(withIdentifier: "facultySegue", sender: self)

                ApplicationState.sharedState.LoggedIn = true
                return
            }
            errorLabel.isHidden = false
           }
        }
    }
    
    
    @IBAction func segmentedController(_ sender: Any) {
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
        
        self.retrieveData(path: "Residents")
        self.retrieveDataFaculty(path: "Faculty")
        
        
        if defaults.object(forKey: "BadgeNumberCounter") == nil {
            
            UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
                if error != nil {
                    self.defaults.set(true, forKey: "BadgeNumberCounter")
                    return
                }
                self.defaults.set(false, forKey: "BadgeNumberCounter")
            }
        }
        
        self.view.isUserInteractionEnabled = false
        super.view.addSubview(loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loading.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
            
            
           self.checkResults(data: self.loginInfoFaculty)
            self.checkResults(data: self.loginInfoStudent)
            
        }
        usernameBox.delegate = self
        loginBox.delegate = self
    }
    
    func checkResults(data: Any?){
        if data == nil {
                 let alert = UIAlertController(title: "Error Retrieving Data", message: "No data to retrieve or poor connection.", preferredStyle: .alert)
                 self.present(alert, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.Login.layer.cornerRadius = 10
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    

    func retrieveData(path: String){
        
        
        DispatchQueue.main.async {
            self.ref.child(path).observe(.value) { (data) in
                guard let value = data.value as? [String: Dictionary<String, Any>] else {
                    return }
                for each in value {
                    guard let password = each.value["Password"] else {return}
                    self.loginInfoStudent.append((username: each.key, password: password))
                }
            }
        }
    }
    
    func retrieveDataFaculty(path: String) {
 
        DispatchQueue.main.async {
            self.ref.child(path).observe(.value) { (data) in
                guard let value = data.value as? [String: Dictionary<String, Any>] else { return }
                
                for each in value {
                    guard let password = each.value["Password"] else {return}
                    self.loginInfoFaculty.append((username: each.key, password: password))
                }
            }
            
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
        let framePosition = self.view.frame.origin.y
        
        switch (textField.isTouchInside, framePosition) {
            
        case (true, .zero):
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
                self.view.frame.origin = .init(x: 0, y: -170)
            }, completion: nil)
            
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        let framePosition = self.view.frame.origin.y
        
        if framePosition != .zero {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame.origin = .init(x: 0, y: 0)
            }, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
    
    
    
}
