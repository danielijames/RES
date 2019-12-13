//
//  facultyfilterController.swift
//  RES
//
//  Created by Daniel James on 12/11/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class facultyfilterController: UIViewController {
    var evalData: evaluationData?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func technicalEvalButton(_ sender: Any) {
        performSegue(withIdentifier: "technicalSegue", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
