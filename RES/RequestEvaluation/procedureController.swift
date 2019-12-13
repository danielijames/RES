import UIKit
import FirebaseDatabase

class procedureController: UITableViewController {
    
    var proceduresArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveData(path: "Operation")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return proceduresArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "What Procedure Will you be Performing?"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "procedureCells", for: indexPath)
        cell.textLabel?.text = proceduresArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        evaluationData.procedure = proceduresArray[indexPath.row]
    }

    func retrieveData(path: String) {
    let ref = Database.database().reference()
    ref.child(path).observe(.value) { (data) in
        guard let value = data.value as? [String: Any] else { return }

        for i in value {
            self.proceduresArray.append(i.key)
        }
        self.tableView.reloadData()}
    }

}
