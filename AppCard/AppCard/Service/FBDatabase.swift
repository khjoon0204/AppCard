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
    
    /// childAutoId 순으로 페이징
    /// - Parameters:
    ///   - lastKey: 마지막 childAutoId ex) "10"
    ///   - size: <#size description#>
    ///   - completion: <#completion description#>
    static func listPagination(startingAt lastKey: String = "", size: UInt = 10, completion: (([AnyObject]?) -> Void)?){
        self.ref.child("list")
            .queryOrderedByKey()
            .queryStarting(atValue: lastKey)
            .queryLimited(toFirst: size)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if let list = snapshot.value as? [AnyObject]{
                    completion?(list)
                }
                else{print("list 가져오기 실패! snapshot=\(snapshot)");completion?(nil)}
            }) { (error) in
                print(error.localizedDescription);completion?(nil)
            }
    }
    
    /// closeDate 순서로 페이징
    /// - Parameters:
    ///   - lastKey: 마지막 closeDate string: yyyyMMddhhmmss
    ///   - size: <#size description#>
    ///   - completion: <#completion description#>
    static func listPagination(startingAtDate lastKey: String? = nil, size: UInt = 10, completion: (([AnyObject]?) -> Void)?){
        let f = DateFormatter(withFormat: "yyyyMMddhhmmss")
        let today = f.string(from: Date())
        self.ref.child("list")
            .queryOrdered(byChild: "closeDate")
            .queryStarting(atValue: lastKey == nil ? today : lastKey, childKey: "closeDate")
            .queryLimited(toFirst: size)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if let list = snapshot.value as? [AnyObject]{
                    completion?(list)
                }
                else{print("list 가져오기 실패! snapshot=\(snapshot)");completion?(nil)}
            }) { (error) in
                print(error.localizedDescription);completion?(nil)
            }
    }

}
