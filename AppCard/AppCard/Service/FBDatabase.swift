//
//  FBDatabase.swift
//  AppCard
//
//  Created by N17430 on 2021/02/03.
//

import Foundation
import Firebase

class FBDatabase{
    static private(set) var ref = Database.database().reference()
    static func list(completion: (([AnyObject]?) -> Void)?){
        self.ref.child("list").observeSingleEvent(of: .value, with: { (snapshot) in
            if let list = snapshot.value as? [AnyObject]{
                completion?(list)
            }
            else{print("list 가져오기 실패! snapshot=\(snapshot)");completion?(nil)}
          }) { (error) in
            print(error.localizedDescription);completion?(nil)
        }
    }
    
}
