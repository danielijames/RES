//
//  filterViewController.swift
//  RES
//
//  Created by Daniel James on 10/19/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class filterViewController: UIViewController {
    weak var evalData: evaluationData?
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navBarSetup(title: "Request or Review Evaluations")
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
        })
    }

    
    @objc func logoutNow(){
        print("buttonTapped")
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController")
        dismiss(animated: true) {
            self.present(loginViewController!, animated: true, completion: nil)
        }
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.isToolbarHidden = false
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.isToolbarHidden = true
//    }

}
