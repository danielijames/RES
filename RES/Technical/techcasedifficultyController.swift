//
//  techcasedifficultyController.swift
//  RES
//
//  Created by Daniel James on 12/13/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techcasedifficultyController: UITableViewController {
        
        var casedifficultyArray = [String]()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.retrieveData(path: "Technical/CaseDifficulty")
            navBarSetup(title: "Choose Difficulty")
            
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

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return casedifficultyArray.count
        }
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
        }
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Case Difficulty?"
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "caseDifficultyCells", for: indexPath)
            cell.textLabel?.text = casedifficultyArray[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            gradingTechnicalData.shared.caseDifficulty = casedifficultyArray[indexPath.row]
        }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
    

        func retrieveData(path: String) {
        let ref = Database.database().reference()
        ref.child(path).observe(.value) { (data) in
            guard let value = data.value as? [String: Any] else { return }
            
            for each in value {
                self.casedifficultyArray.append(each.key)

                }
            self.tableView.reloadData()}
        }

    }
