
import UIKit
import FirebaseDatabase
import GoogleSignIn

class reviewGradedEval: UITableViewController {
    let ref = Database.database().reference()
    let defaults = UserDefaults.standard
    var myEvaluationsArray = [String]()
    var myEvaluations = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let name = defaults.string(forKey: "name") else {return}
        let path = "Residents/\(name)/Requests"
        
        self.retrieveData(path: path)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEvaluationsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Review Submitted Evaluations"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsCell", for: indexPath) as! RequestsCell
        cell.dateLabel.text = myEvaluationsArray[indexPath.row]
        cell.procedureLabel.text = myEvaluations[indexPath.row]
        return cell
    }
    
    //perform action when row is selected
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        evalData?.procedure = proceduresArray[indexPath.row]
//    }
    
    //transfer data forward
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! dateSelectorView
//        destinationVC.evalData = self.evalData!
//    }

    func retrieveData(path: String) {
    let ref = Database.database().reference()
    ref.child(path).observe(.value) { (data) in
        guard let value = data.value as? [String: Any] else { return }

        for i in value {
            self.myEvaluations.append(i.value as! String)
            self.myEvaluationsArray.append(i.key)
        }
        self.tableView.reloadData()}
    }

}
