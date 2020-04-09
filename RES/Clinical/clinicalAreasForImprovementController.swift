//
//  clinicalAreasForImprovementController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import Foundation
import FirebaseDatabase

private enum buttonAndLabel: String{
    case i1 = "Private Office"
    case i2 = "Orange Clinic"
    case i3 = "Trauma Clinic"
    case i4 = "Rounds"
    case i5 = "ED/Floor"
}

class clinicalsettingController: UIViewController {
    var XYZ_Array = [String]()
    var buttonArray = [UIButton]()
    
    
    @IBOutlet weak var i1: UIButton!{
        didSet{
            i1.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i1.titleLabel?.text = buttonAndLabel.i1.rawValue
            i1.frame.size = .init(width: 200, height: 60)
            i1.layer.cornerRadius = 10
            i1.backgroundColor = .clear
            buttonArray.append(i1)
        }
    }
    @IBOutlet weak var i2: UIButton!
    {
        didSet{
            i2.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i2.titleLabel?.text = buttonAndLabel.i2.rawValue
            i2.frame.size = .init(width: 200, height: 60)
            i2.layer.cornerRadius = 10
            i2.backgroundColor = .clear
            buttonArray.append(i2)
        }
    }
    @IBOutlet weak var i3: UIButton!
    {
        didSet{
            i3.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i3.titleLabel?.text = buttonAndLabel.i3.rawValue
            i3.frame.size = .init(width: 200, height: 60)
            i3.layer.cornerRadius = 10
            i3.backgroundColor = .clear
            buttonArray.append(i3)
        }
    }
    @IBOutlet weak var i4: UIButton!
    {
        didSet{
            i4.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i4.titleLabel?.text = buttonAndLabel.i4.rawValue
            i4.frame.size = .init(width: 200, height: 60)
            i4.layer.cornerRadius = 10
            i4.backgroundColor = .clear
            buttonArray.append(i4)
        }
    }
    @IBOutlet weak var i5: UIButton!
    {
        didSet{
            i5.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i5.titleLabel?.text = buttonAndLabel.i5.rawValue
            i5.frame.size = .init(width: 200, height: 60)
            i5.layer.cornerRadius = 10
            i5.backgroundColor = .clear
            buttonArray.append(i5)
        }
    }

    @objc func imageTap(sender: UIButton){
        switch sender.backgroundColor {
        case UIColor.clear:
            performSegue(withIdentifier: "clinicalTwo", sender: self)
            sender.backgroundColor = .systemGreen
            gradingClinicalData.shared.setting = sender.titleLabel?.text
        default:
            sender.backgroundColor = UIColor.clear
            gradingClinicalData.shared.setting = nil
        }
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.retrieveData(path: "Technical/Improvement")
            navBarSetup(title: "Setting?")
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
                self.XYZ_Array.append(each.key)
            }
        }
    }
}
