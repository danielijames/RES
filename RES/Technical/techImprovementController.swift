//
//  techImprovementController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase



class techImprovementController: UIViewController {
    var XYZ_Array = [String]()
    @IBOutlet weak var i1: UIButton!{
        didSet{
            i1.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i1.titleLabel?.text = XYZ_Array[0]
            i1.frame.size = .init(width: 60, height: 60)
        }
    }
    @IBOutlet weak var i2: UIButton!
    {
        didSet{
            i2.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i2.titleLabel?.text = XYZ_Array[1]
            i2.frame.size = .init(width: 60, height: 60)
        }
    }
    @IBOutlet weak var i3: UIButton!
    {
        didSet{
            i3.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i3.titleLabel?.text = XYZ_Array[2]
            i3.frame.size = .init(width: 60, height: 60)
        }
    }
    @IBOutlet weak var i4: UIButton!
    {
        didSet{
            i4.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i4.titleLabel?.text = XYZ_Array[3]
            i4.frame.size = .init(width: 60, height: 60)
        }
    }
    @IBOutlet weak var i5: UIButton!
    {
        didSet{
            i5.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i5.titleLabel?.text = XYZ_Array[4]
            i5.frame.size = .init(width: 60, height: 60)
        }
    }
    @IBOutlet weak var i6: UIButton!
    {
        didSet{
            i6.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i6.titleLabel?.text = XYZ_Array[5]
            i6.frame.size = .init(width: 60, height: 60)
        }
    }
    @IBOutlet weak var i7: UIButton!
    {
        didSet{
            i7.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
            i7.titleLabel?.text = XYZ_Array[6]
            i7.frame.size = .init(width: 60, height: 60)
        }
    }
    
    @objc func imageTap(sender: UIButton){
        
        if sender.currentImage == UIImage(systemName: "circle"){
            sender.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            gradingTechnicalData.shared.improvements.insert(sender.titleLabel?.text)
            
            sender.tintColor = .green
            
        } else {
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            sender.tintColor = .black
            
            gradingTechnicalData.shared.improvements.remove(sender.titleLabel?.text)
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            self.retrieveData(path: "Technical/Improvement")
            navBarSetup(title: "Improvements?")
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
