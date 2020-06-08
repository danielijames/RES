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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var typeOfUser = ""
    let defaults = UserDefaults.standard
    let firebaseFunction = firebaseFunctions()
    var loginInfoStudent = [(username: String, password: Any)]()
    var loginInfoFaculty = [(username: String, password: Any)]()
    let loading = loadingView()
    
    @IBAction func loginButton(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame.origin = .init(x: 0, y: 0)
        }, completion: nil)
        
        guard let username = self.usernameBox.text else {return}
        guard let password = self.loginBox.text else {return}
        
        switch self.typeOfUser {
        case "Student":
            for name in self.loginInfoStudent where name.username == username && "\(String(describing: name.password))" == password {
                evaluationData.shared.userName = username
                
//                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "filterViewController")
//                self.navigationController?.pushViewController(controller, animated: true)
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
    
    
    @IBAction func segmentedController(_ sender: Any) {
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        usernameBox.delegate = self
        loginBox.delegate = self
        print("override view did load")
        self.retrieveData(path: "Residents")
        self.retrieveDataFaculty(path: "Faculty")
        self.typeOfUser = segmentController.selectedSegmentIndex == 0 ? "Student" : "Instructor"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.Login.layer.cornerRadius = 10
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
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
