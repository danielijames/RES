//
//  gradeEvalController.swift
//  RES
//
//  Created by Daniel James on 12/6/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techevalController: UITableViewController {
  
    var evals = [[(student: String, date: String)](),[(student: String, date: String)]()]
    var ungradedRequests: (student: String, date: String)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
 
        guard let username = evaluationData.userName else {return}
        retrieveDataUngradedRequests(path: "Faculty/\(username)/Ungraded Requests")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return evals[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Requested Evaluations"}
        
        return "Graded Requests"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath) as! gradeEvalsCell
            cell.timeLabel.text = evals[indexPath.section][indexPath.row].student
            cell.fromLabel.text = evals[indexPath.section][indexPath.row].date
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        evalData.userName = evalsToGrade[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! attendeeNameController
//        destinationVC.evalData = self.evalData
    }
    
        func retrieveDataUngradedRequests(path: String) {
        let ref = Database.database().reference()
            
            DispatchQueue.main.async {
                ref.child(path).observe(.value) { (data) in
                  guard let value = data.value as? [String: String] else { return }
                    print(value.values)
                    print(value.keys)
                    print(data.key)
                    
                    for each in value {
                        self.ungradedRequests = (student: each.key, date: each.value)
                        self.evals[0].append(self.ungradedRequests ?? (student: "No Students", date: "No Evals"))
                     }
                    self.tableView.reloadData()
                }
                
            }
        
        }

}
