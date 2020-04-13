//
//  graphViewContoller.swift
//  RES
//
//  Created by Daniel James on 4/12/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit

class graphViewContoller: UIViewController, GraphViewDelegate {
    let screenView = GraphView()
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.delegate = self
        navBarSetup(title: "Monitor Your Evaluations")
        
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
    
    func Count() -> (Sent: CGFloat, Graded: CGFloat)? {
        screenView.TotalLabel.text = """
                          🔵      Graded: \(8)
                          🟢      Sent: \(35)
                   """
        return (Sent: 35, Graded: 8)
    }

}
