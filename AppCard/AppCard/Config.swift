//
//  Config.swift
//  main
//

import Foundation
@objcMembers class Config: NSObject{
    static private var instance: Config? // instance
    static var shared: Config!{ // global accessor
        if instance == nil{
            instance = Config()
        }
        return Config.instance
    }
    let PRINT_PREFIX = "Log: "
//    static let mainSearchUrl = "http://search-tour.interpark.com/#/"
    
    // Required
    let userName: String
    
    // Optional
    var userCountry: String = ""
    
    override init() {
        self.userName = ""
        super.init()
        Config.instance = self
        print("userName=\(userName)")
        settingWarning()
    }
    
    private func settingWarning(){
        // Warning!!
        if userName == ""{print(PRINT_PREFIX+"초기세팅값이 없습니다: \(userName.self): \(userName)")}
    }
    
}
