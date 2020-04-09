//
//  UIComponents.swift
//  RES
//
//  Created by Daniel James on 3/21/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var screenSize: CGRect {
        return UIScreen.main.bounds

    }
    
    
    func logoutButton(vc: UIViewController, selector: Selector, closure: (()->Void)?){
        let bgview = UIBarButtonItem.init(title: "Logout", style: .done, target: self, action: selector)
        bgview.tintColor = .red
        vc.navigationItem.rightBarButtonItem = bgview
    }
    

    
    func BackButton(vc: UIViewController, selector: Selector, closure: (()->Void)?){
        let bbview = UIBarButtonItem.init(title: "Back", style: .done, target: self, action: selector)
        bbview.tintColor = .black
        vc.navigationItem.leftBarButtonItem = bbview
    }
    
    
    
    
    
    func navBarSetup(title: String){
    self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.titleView?.tintColor = .black
        self.navigationItem.title = title
    }

}


