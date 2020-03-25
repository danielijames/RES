//
//  attendeeNameController.swift
//  RES
//
//  Created by Daniel James on 11/27/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class attendeeNameController: UITableViewController {
    
    var attendeesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveData(path: "Faculty")
        self.additionalSafeAreaInsets = .init(top: 30, left: 0, bottom: 0, right: 0)
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
        return attendeesArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Who Would You Like To Evaluate You?"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeeNames", for: indexPath)
        cell.textLabel?.text = attendeesArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        evaluationData.shared.attendeeName = attendeesArray[indexPath.row]
    }
  
    
    func retrieveData(path: String) {
    let ref = Database.database().reference()
    ref.child(path).observe(.value) { (data) in
        guard let value = data.value as? [String: Any] else { return }

        for i in value {
            self.attendeesArray.append(i.key)
        }
        self.tableView.reloadData()}
    }

}
