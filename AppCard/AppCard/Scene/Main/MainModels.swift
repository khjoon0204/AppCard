//
//  MainModels.swift
//  AppCard
//
//  Created by N17430 on 2021/02/03.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Main
{
    struct List{
        var list: [ListElement] = []
        var count: Int{
            return self.list.count
        }
        
        func object(indexOf idx: Int) -> ListElement?{
            guard idx < list.count else { print("index에 해당하는 element가 없습니다 index=\(idx)"); return nil }
            return self.list[idx]
        }
        
        // MARK: - ListElement
        struct ListElement: Codable {
            var category : CategoryType?
            var displayType: DisplayType?
            var updateDate, openDate, closeDate, expireDate, dDayDate, corpName: String?
            var display: Display?
        }
        
        // MARK: - Display
        struct Display: Codable {
            var headerTitle, mainTitle, subTitle, backImg: String?
            var labelImg, centerImg: String?
            var mainColor, fontColor: String?
            var labelText, iconImg, size, title: String?
            var rightImg: String?
        }
        
        enum CategoryType: String, Codable {
            case coupon = "coupon"
            case feature = "feature"
            case news = "news"
            case noti = "noti"
            case shop = "shop"
        }
                
        enum DisplayType: String, Codable {
            case displayTypeDefault = "default"
            case noBack = "noBack"
            case none = "none"
        }
        
        internal init(list: [Main.List.ListElement] = []) {
            self.list = list
        }
        
        init(objs: [AnyObject]) {
            var eles: [ListElement] = []
            for i in objs{
                var ele = ListElement()
                if let val = i["category"] as? String{ ele.category = CategoryType(rawValue: val) }
                if let val = i["displayType"] as? String{ ele.displayType = DisplayType(rawValue: val) }
                if let val = i["updateDate"] as? String{ ele.updateDate = val }
                if let val = i["openDate"] as? String{ ele.openDate = val }
                if let val = i["closeDate"] as? String{ ele.closeDate = val }
                if let val = i["expireDate"] as? String{ ele.expireDate = val }
                if let val = i["dDayDate"] as? String{ ele.dDayDate = val }
                if let val = i["corpName"] as? String{ ele.corpName = val }
                if let d = i["display"] as? [String:AnyObject]{
                    ele.display = Display()
                    if let val = d["headerTitle"] as? String{ ele.display?.headerTitle = val }
                    if let val = d["mainTitle"] as? String{ ele.display?.mainTitle = val }
                    if let val = d["subTitle"] as? String{ ele.display?.subTitle = val }
                    if let val = d["backImg"] as? String{ ele.display?.backImg = val }
                    if let val = d["labelImg"] as? String{ ele.display?.labelImg = val }
                    if let val = d["centerImg"] as? String{ ele.display?.centerImg = val }
                    if let val = d["mainColor"] as? String{ ele.display?.mainColor = val }
                    if let val = d["fontColor"] as? String{ ele.display?.fontColor = val }
                    if let val = d["labelText"] as? String{ ele.display?.labelText = val }
                    if let val = d["iconImg"] as? String{ ele.display?.iconImg = val }
                    if let val = d["size"] as? String{ ele.display?.size = val }
                    if let val = d["title"] as? String{ ele.display?.title = val }
                    if let val = d["rightImg"] as? String{ ele.display?.rightImg = val }
                }
                if ele.displayType == nil{continue}
                eles.append(ele)
            }
            self.list = eles
        }
        
        mutating func append(contensOf list: Main.List){
            self.list.append(contentsOf: list.list)
        }
        
    }
    
    // MARK: Use cases
    
    enum GetList
    {
        struct Request
        {
        }
        struct Response
        {
            var list: List
        }
        struct ViewModel
        {
            var list: List
        }
    }
}
