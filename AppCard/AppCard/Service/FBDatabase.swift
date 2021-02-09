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
    
//    static func list(completion: (([AnyObject]?) -> Void)?){
//        self.ref.child("list").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let list = snapshot.value as? [AnyObject]{
//                completion?(list)
//            }
//            else{print("list 가져오기 실패! snapshot=\(snapshot)");completion?(nil)}
//          }) { (error) in
//            print(error.localizedDescription);completion?(nil)
//        }
//    }
    
    /// key 순으로 정렬하여 페이징
    /// - Parameters:
    ///   - lastKey:
    ///   - size: <#size description#>
    ///   - completion: <#completion description#>
    static func listPagination(startingAt lastKey: String = "", size: UInt = 10, completion: (([DataSnapshot]?) -> Void)?){
        print("lastKey=\(lastKey)")
        self.ref.child("list")
            .queryOrderedByKey()
            .queryStarting(atValue: lastKey)
            .queryLimited(toFirst: size)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if let list = snapshot.children.allObjects as? [DataSnapshot]{
                    var list = list
                    if lastKey != Main.GetList.FIRST_KEY{ list.removeFirst() }
                    print("snapshot.allObjects first=\(String(describing: list.first?.key))")
                    completion?(list)
                }
                else{print("list 가져오기 실패! snapshot=\(snapshot)");completion?(nil)}
            }) { (error) in
                print(error.localizedDescription);completion?(nil)
            }
    }
    
//    /// closeDate 순서로 페이징
//    /// - Parameters:
//    ///   - lastKey: 마지막 closeDate string: yyyyMMddhhmmss
//    ///   - size: <#size description#>
//    ///   - completion: <#completion description#>
//    static func listPagination(startingAt lastKey: String = "", size: UInt = 10, completion: (([String:AnyObject]?) -> Void)?){
//        print("lastKey=\(lastKey)")
//        let f = DateFormatter(withFormat: "yyyyMMddhhmmss")
//        self.ref.child("list")
//            .queryOrdered(byChild: "updateDate")
//            .queryStarting(atValue: lastKey, childKey: "updateDate")
//            .queryLimited(toFirst: size)
//            .observeSingleEvent(of: .value, with: { (snapshot) in
//                if let list = snapshot.value as? [String:AnyObject]{
//                    print("snapshot.value first=\(list.first?.key)")
////                    completion?(list)
//                }
//                if let list = snapshot.children.allObjects as? [DataSnapshot]{
//
//                    print("snapshot.allObjects first=\(list.first?.key)")
//                }
//                else{print("list 가져오기 실패! snapshot=\(snapshot)");completion?(nil)}
//            }) { (error) in
//                print(error.localizedDescription);completion?(nil)
//            }
//    }

}
