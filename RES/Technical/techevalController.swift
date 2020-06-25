//
//  gradeEvalController.swift
//  RES
//
//  Created by Daniel James on 12/6/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct JSONData: Decodable {
    var date: String?
    var procedure: String?
    var attendeeName: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case procedure = "procedure"
        case attendeeName = "attendeeName"
    }
}

class techevalController: UITableViewController {
    var ungradedRequests: (student: String, date: String)?
    var gradedRequests: (student: String, date: String)?
    var data: DataSnapshot?
    var retrievedData: [JSONData]?
    let defaults = UserDefaults.standard
    var keys: Dictionary<String, Any>.Keys!
    
    @IBAction func emptyEvalPressed(_ sender: Any) {
        ApplicationState.sharedState.isOnUnpromptedPath = true
        self.navigationController?.performSegue(withIdentifier: "typeEvalFilter", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup(title: "Pending Requests")
        guard let username = evaluationData.shared.userName else {return}
        retrieveDataUngradedRequests(path: "Faculty/\(username)/Ungraded Requests")
        self.tableView.reloadData()
        logoutButton(vc: self, selector: #selector(logoutNow), closure: {
            ApplicationState.sharedState.LoggedIn = false
        })
        BackButton(vc: self, selector: #selector(popController), closure: nil)
    }
    
    @objc func popController(){
    self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func logoutNow(){
        wipeMemory()
        self.navigationController?.popToRootViewController(animated: true)
//        ApplicationState.sharedState.LoggedIn = false
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retrievedData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return "Requested Evaluations"
    }
    
    func decodeData() {
        let retrievedData = try! JSONDecoder().decode([JSONData].self, from: self.data!.listToJSON)
        self.retrievedData = retrievedData
    
        gradingTechnicalData.shared.receivedData = retrievedData
        self.tableView.reloadData()
        
        guard let keys = self.keys?.count else {return}
        
        if retrievedData.count > 0 && keys > 0 {
          combineData()
        }
        
        
    }
    
    func combineData(){
        for i in 0...(self.retrievedData!.count - 1){
            let arrayofkeys = Array(self.keys)
            gradingTechnicalData.shared.combinedKeywithData.append([arrayofkeys[i]:self.retrievedData![i]])
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath) as! gradeEvalsCell
        
        if let cellData = self.retrievedData {
            
            guard let attendeeName = cellData[indexPath.row].attendeeName, let procedure = cellData[indexPath.row].procedure, let date = cellData[indexPath.row].date else {return cell}
            cell.attendeeName.text = attendeeName
            cell.procedure.text = "Procedure: " + procedure
            cell.date.text = "Date: " + date
            return cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! gradeEvalsCell
        
        gradingTechnicalData.shared.attendeeName = cell.attendeeName.text
        gradingTechnicalData.shared.procedure = cell.procedure.text
        gradingTechnicalData.shared.date = cell.date.text
        
        gradingClinicalData.shared.attendeeName = cell.attendeeName.text
        gradingClinicalData.shared.date = cell.date.text
        
        ApplicationState.sharedState.isOnUnpromptedPath = false
        
        for (i,x) in self.keys.enumerated(){
            if i == indexPath.row{
                gradingTechnicalData.shared.selectedEvalDate = x
            }
        }
        self.navigationController?.performSegue(withIdentifier: "typeEvalFilter", sender: self)
    }
    
    public func retrieveDataUngradedRequests(path: String) {
        let ref = Database.database().reference()
        DispatchQueue.main.async {
            ref.child(path).observe(.value) { (data) in
               print(data)
            //Putting the Data in a format for which we can grab the keys
                guard let value = data.value as? [String: Any] else { return }
                self.keys = value.keys
 
            self.data = data
            self.defaults.set(Int(data.childrenCount), forKey: "BadgeCount")
            UIApplication.shared.applicationIconBadgeNumber = Int(data.childrenCount)
            self.decodeData()
            self.tableView.reloadData()
        }
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueHelper(nextVC: techevalResidentsController())
    }
}


extension Dictionary {
    var JSON: Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }
}


extension DataSnapshot {
  var valueToJSON: Data {
      guard let dictionary = value as? [String: Any] else {
          return Data()
      }
      return dictionary.JSON
  }

  var listToJSON: Data {
      guard let object = children.allObjects as? [DataSnapshot] else {
          return Data()
      }

      let dictionary: [NSDictionary] = object.compactMap { $0.value as? NSDictionary }

      do {
          return try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      } catch {
          return Data()
      }
  }
}
