//
//  magnifiedCellController.swift
//  RES
//
//  Created by Daniel James on 4/13/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class magnifiedCellController: UITableViewController {
    
    var EvaluationDate: String!
    var categories = [String]()

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myResultsCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myResultsCell")
        guard let username: String = evaluationData.shared.userName else {return}
        guard let datePath: String = self.EvaluationDate else {return}
        retrieveDataGraded(path: "Residents/\(username)/Graded Evaluations/\(datePath)")
        self.tableView.reloadData()
    }

//    init(with EvaluationDate: String) {
//
////        super.init(nibName: "magnifiedCellController", bundle: nil)
////        self.EvaluationDate = EvaluationDate
//    }
    
    
       func retrieveDataGraded(path: String) {
           let ref = Database.database().reference()
           DispatchQueue.main.async {
               ref.child(path).observe(.value) { (data) in
                guard let values = data.value as? [String:Any] else {return}
                //dropping the boolean isGraded value

                for i in values{
                    if i.value is String {
                        let newValue: String = i.value as! String
                        self.categories.append(i.key + ": \n" + newValue)
                    } else {
                        let newValue: Array = i.value as! Array<Any>
                        self.categories.append(i.key + ": \n" + newValue.description)
                    }
                }
                self.tableView.reloadData()
           }
         }
       }
    

}
