//
//  techevalResidentsController.swift
//  RES
//
//  Created by Daniel James on 12/12/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class techevalResidentsController: UITableViewController {

        
        var residentsArray = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.retrieveData(path: "Residents")
            
            navBarSetup(title: "Pick Resident")
            
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
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController")
            self.present(loginViewController!, animated: true, completion: nil)
        }

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return residentsArray.count
        }
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
        }
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "For Which Resident?"
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "residentsNames", for: indexPath)
            cell.textLabel?.text = residentsArray[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            gradingTechnicalData.shared.residentEvaluated = residentsArray[indexPath.row]
        }
        

        func retrieveData(path: String) {
        let ref = Database.database().reference()
        ref.child(path).observe(.value) { (data) in
            guard let value = data.value as? [String: Any] else { return }
            
            for each in value {
                self.residentsArray.append(each.key)

                }
            self.tableView.reloadData()}
        }

    }
