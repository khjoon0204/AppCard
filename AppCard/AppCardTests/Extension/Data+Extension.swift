//
//  Data+Extension.swift
//  AppCardTests
//
//  Created by N17430 on 2021/02/08.
//

import Foundation
extension Data{
    func convertToDictionary() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

}
