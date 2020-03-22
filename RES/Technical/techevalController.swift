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
  
    var ungradedRequests: (student: String, date: String)?
    var gradedRequests: (student: String, date: String)?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = evaluationData.shared.userName else {return}
        retrieveDataUngradedRequests(path: "Faculty/\(username)/Ungraded Requests")
        retrieveDataGradedRequests(path: "Faculty/\(username)/Graded Requests")
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return evaluationData.evalSet[section].count
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
            cell.timeLabel.text = evaluationData.evalSet[indexPath.section][indexPath.row].student
            cell.fromLabel.text = evaluationData.evalSet[indexPath.section][indexPath.row].date
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            evaluationData.selectedEval = evaluationData.evalSet[0][indexPath.row]
            performSegue(withIdentifier: "facultyFilterSegue", sender: self)
        default: break
            //do nothing
        }
    }
    
        func retrieveDataUngradedRequests(path: String) {
        let ref = Database.database().reference()
            
            DispatchQueue.main.async {
                ref.child(path).observe(.value) { (data) in
                  guard let value = data.value as? [String: String] else { return }
                    
                    evaluationData.evalSet[0] = (value.map { (student: $0.key, date: $0.value)})

                    self.tableView.reloadData()
                }
                
            }
        }
    
    func retrieveDataGradedRequests(path: String) {
    let ref = Database.database().reference()
        
        DispatchQueue.main.async {
            ref.child(path).observe(.value) { (data) in
              guard let value = data.value as? [String: String] else { return }
                
                evaluationData.evalSet[1] = (value.map { (student: $0.key, date: $0.value)})
                self.tableView.reloadData()
            }
            
        }
    }

}
