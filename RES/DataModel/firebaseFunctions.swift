//
//  firebaseFunctions.swift
//  RES
//
//  Created by Daniel James on 11/27/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import Foundation
import FirebaseDatabase

class firebaseFunctions{
    let ref = Database.database().reference()
//    
//    
//
//    
//    func retrieveData(path: String) -> Array<String> {
//        var dataArray = [String]()
//        ref.child(path).observe(.value) { (data) in
//        guard let value = data.value as? [String: Any] else { return }
//        for i in value {
//            dataArray.append(i.key)
//            print(dataArray)
//          }
//  //reload the tableView!
//        }
//    }
    

    func postPairData(path: String, key: String, value: String) {
        print("POSTING")
        self.ref.child(path).child(key).setValue(["Email":value])
    //reload the tableView!
          }
    func postData(path: String, value: String) {
        print("POSTING")
        self.ref.child(path).setValue(["Name":value])
    //reload the tableView!
          }
    
}
