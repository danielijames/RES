//
//  magnifiedCellController.swift
//  RES
//
//  Created by Daniel James on 4/13/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class magnifiedCellController: UIViewController {
    
    var EvaluationDate: String!
    let screenView = MagnifiedCellView()
    
    override func loadView() {
        view = screenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username: String = evaluationData.shared.userName else {return}
        guard let datePath: String = self.EvaluationDate else {return}
        retrieveDataGraded(path: "Residents/\(username)/Graded Evaluations/\(datePath)")
        // Do any additional setup after loading the view.
    }
    
    init(with EvaluationDate: String) {
        super.init(nibName: "magnifiedCellController", bundle: nil)
        self.EvaluationDate = EvaluationDate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    
       func retrieveDataGraded(path: String) {
           let ref = Database.database().reference()
           DispatchQueue.main.async {
               ref.child(path).observe(.value) { (data) in
                print(data)
                let dataString = "\(data)"
                let dataStringAdjusted = "\(dataString.dropFirst(28).dropLast(3))"
                self.screenView.infoLabel.text = dataStringAdjusted
           }
         }
       }


}
