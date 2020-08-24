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
    static var indexPathOfComments: IndexPath?

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myResultsCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row]
        if cell.textLabel?.text?.prefix(3).description == "com" {
            cell.textLabel?.text = cell.textLabel?.text
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.contentMode = .top
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.textAlignment = .left
            
            if let text = cell.textLabel?.text?.count, text < 50 {
              magnifiedCellController.indexPathOfComments = nil
            } else {
              magnifiedCellController.indexPathOfComments = indexPath
            }
        } else {
            cell.backgroundView = nil
            magnifiedCellController.indexPathOfComments = nil
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == magnifiedCellController.indexPathOfComments {
            return 400
        }
        return 120
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
                let valuesSorted = values.sorted {$0.key < $1.key}

                for i in valuesSorted{
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
