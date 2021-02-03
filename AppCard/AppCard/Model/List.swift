//
//  List.swift
//  AppCard
//
//  Created by N17430 on 2021/02/03.
//

import Foundation

// MARK: - List
struct List: Codable {
    var list: [ListElement]?
    
    enum CategoryType: String, Codable{
        case noti
        case coupon
        case shop
        case feature
        case news
    }

    enum DisplayType: String, Codable{
        case `default`
        case noBack
        case none
    }

    // MARK: - ListElement
    struct ListElement: Codable {
        var category : CategoryType?
        var displayType: DisplayType?
        var display: Display?
    }
    
    // MARK: - Display
    struct Display: Codable {
        var topTitle, mainTitle, desc, backImg: String?
        var labelImg, centerImg, mainColor, fontColor: String?
        var labelText, iconImg, size, title: String?
        var subTitle, rightImg: String?
    }
}

extension List{
    static func get(obj: [AnyObject]) -> List{
        var list: [ListElement] = []
        for i in obj{
            if let category = i["category"] as? String{ print(category) }
            if let d = i["display"] as? [String:AnyObject]{
                if let desc = d["desc"] as? String{ print(desc) }
            }
            
        }
        return List(list: list)
    }
}
