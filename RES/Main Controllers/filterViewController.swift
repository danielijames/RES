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
       navBarSetup(title: "Evaluation Home")
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
        })
        
        BackButton(vc: self, selector: #selector(goBack), closure: nil)
    }
    
    @objc func goBack(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    @objc func logoutNow(){
        print("buttonTapped")
        self.navigationController?.popToRootViewController(animated: true)
        }
        
    @IBAction func requestEval(_ sender: Any) {
        self.navigationController?.performSegue(withIdentifier: "request1", sender: self)
    }

    
    @IBAction func reviewEval(_ sender: Any) {
        self.navigationController?.performSegue(withIdentifier: "reviewGraded", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueHelper(nextVC: attendeeNameController())
    }
}
