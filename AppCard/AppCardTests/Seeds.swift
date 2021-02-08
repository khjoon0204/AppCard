//
//  Seeds.swift
//  AppCardTests
//
//  Created by N17430 on 2021/02/08.
//

import Foundation
struct Seeds
{
    struct GetList
    {
        static func mock() -> Main.List{
            var eles: [Main.ListElement] = []
            func getData(name: String, withExtension: String = "json") -> Data {
                let bundle = Bundle(identifier: "com.hjoon.AppCardTests")!
                let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
                let data = try! Data(contentsOf: fileUrl!)
                return data
            }
            if let dic = getData(name: "appcard-export").convertToDictionary() as [String:AnyObject]?,
               let list = dic["list"] as? [String:AnyObject]
            {
                for i in list{
                    if let ele = try? Main.ListElement(from: i.value){
                        var ele2 = ele
                        ele2.key = i.key
                        eles.append(ele2)
                    }
                }
            }
            return Main.List(list: eles, imageDownloadCompletion: nil, objs: [])
        }
    }
}

extension Decodable {
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}
