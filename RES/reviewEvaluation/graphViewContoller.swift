//
//  graphViewContoller.swift
//  RES
//
//  Created by Daniel James on 4/12/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class graphViewContoller: UIViewController, GraphViewDelegate {
    let screenView = GraphView()
    var data: DataSnapshot?
    var dataTwo: DataSnapshot?
    var retrievedData: [gradingCritereon]?
    var sentData: [gradingCritereon]?
    var EvaluationDate: String?
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.delegate = self
        guard let username: String = evaluationData.shared.userName else {return}
    
        retrieveData(path: "Residents/\(username)/Graded Evaluations")
        retrieveDataTwo(path: "Residents/\(username)/Requested Evaluations")
        
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
        let gradedCount = self.retrievedData?.count ?? 0
        let sentCount = self.sentData?.count ?? 0
        screenView.TotalLabel.text = """
                🟢      Sent: \(sentCount)
                🔵      Graded: \(gradedCount)
        """
        return (Sent: CGFloat(sentCount), Graded: CGFloat(gradedCount))
    }
    
    func magnifyCell(with EvaluationDate: String) {
        self.EvaluationDate = EvaluationDate
        
        let nextVC = magnifiedCellController()
        guard let date = self.EvaluationDate else {
            return
        }
        nextVC.EvaluationDate = date
        
        self.navigationController?.pushViewController(nextVC, animated: true)
//        self.navigationController?.performSegue(withIdentifier: "graded1", sender: self)
//        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "magnifiedCellController") as! magnifiedCellController
//        controller.EvaluationDate = EvaluationDate
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func decodeData() {
        let retrievedData = try! JSONDecoder().decode([gradingCritereon].self, from: self.data!.listToJSON)
        self.retrievedData = retrievedData
        self.screenView.collection.reloadData()
        
    }
    
    func decodeDataTwo() {
        let retrievedData = try! JSONDecoder().decode([gradingCritereon].self, from: self.dataTwo!.listToJSON)
        self.sentData = retrievedData
    }

    
    func getData() -> [gradingCritereon]? {
        return self.retrievedData
    }
    
    
        func retrieveData(path: String) {
           let ref = Database.database().reference()
           DispatchQueue.main.async {
               ref.child(path).observe(.value) { (data) in
               self.data = data
               self.decodeData()
               self.screenView.collection.reloadData()
           }
         }
       }
    
    func retrieveDataTwo(path: String) {
        let ref = Database.database().reference()
        DispatchQueue.main.async {
            ref.child(path).observe(.value) { (data) in
            self.dataTwo = data
            self.decodeDataTwo()
        }
      }
    }
    

}
