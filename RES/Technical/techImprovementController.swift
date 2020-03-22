//
//  techImprovementController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techImprovementController: UITableViewController {

        
        var XYZ_Array = [String]()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.retrieveData(path: "Technical/Improvement")
            self.navigationController?.navigationBar.isHidden = false
        }

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return XYZ_Array.count
        }
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
        }
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Improvements to be made?"
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "techimprovementCells", for: indexPath)
            cell.textLabel?.text = XYZ_Array[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            evaluationData.improvements.append(XYZ_Array[indexPath.row])
        }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        evaluationData.improvements.removeAll { (str) -> Bool in
            if str == XYZ_Array[indexPath.row] {
                return true
            }
        return false}
    }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
    

        func retrieveData(path: String) {
        let ref = Database.database().reference()
        ref.child(path).observe(.value) { (data) in
            guard let value = data.value as? [String: Any] else { return }
            
            for each in value {
                self.XYZ_Array.append(each.key)

                }
            self.tableView.reloadData()}
        }

    }
