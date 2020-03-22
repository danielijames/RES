//
//  techpreparationviewController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techpreparationviewController: UITableViewController {
        
        var preparationArray = [String]()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.retrieveData(path: "Technical/Preparation")
            self.navigationController?.navigationBar.isHidden = false
        }

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return preparationArray.count
        }
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
        }
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Preparation?"
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "techpreparationCells", for: indexPath)
            cell.textLabel?.text = preparationArray[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            evaluationData.procedureEvaluated = preparationArray[indexPath.row]
        }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
    

        func retrieveData(path: String) {
        let ref = Database.database().reference()
        ref.child(path).observe(.value) { (data) in
            guard let value = data.value as? [String: Any] else { return }
            
            for each in value {
                self.preparationArray.append(each.key)

                }
            self.tableView.reloadData()}
        }

    }
