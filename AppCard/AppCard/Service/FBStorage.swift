//
//  FBStorage.swift
//  AppCard
//
//  Created by N17430 on 2021/02/03.
//

import Foundation
import UIKit
import Firebase

class FBStorage{
    // Points to the root reference
    static private(set) var storageRef = Storage.storage().reference()
    
    static func image(fileName: String, getData: (( _ image: UIImage?) -> Void)?){
        // Create a reference to the file you want to download
        let islandRef = FBStorage.storageRef.child("images/\(fileName)")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("이미지 가져오기 실패 error=\(error)")
            getData?(nil)
          } else {
            let image = UIImage(data: data!)
            getData?(image)
          }
        }
    }
    
}
