//
//  filterViewController.swift
//  RES
//
//  Created by Daniel James on 10/19/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class filterViewController: UIViewController {
    var evalData: evaluationData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        navigationController?.navigationBar.tintColor = .white
    }

}
