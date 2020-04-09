//
//  clinicalHistoryController.swift
//  RES
//
//  Created by Daniel James on 3/26/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class clinicalHistoryController: UIViewController {
        var XYZ_Array = [String]()
        var buttonArray = [UIButton]()
        
        
        @IBOutlet weak var i1: UIButton!{
            didSet{
                i1.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
                i1.titleLabel?.text = XYZ_Array[0]
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
                i2.titleLabel?.text = XYZ_Array[1]
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
                i3.titleLabel?.text = XYZ_Array[2]
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
                  i4.titleLabel?.text = XYZ_Array[3]
                  i4.frame.size = .init(width: 200, height: 60)
                  i4.layer.cornerRadius = 10
                  i4.backgroundColor = .clear
                  buttonArray.append(i4)
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

    }
