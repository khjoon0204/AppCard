//
//  DateFormatter+Extension.swift
//  checkinnow
//
//  Created by N17430 on 2018. 12. 10..
//  Copyright © 2018년 Interpark INT. All rights reserved.
//

import Foundation

extension DateFormatter{    
    convenience init(withFormat: String) {
        self.init()
        self.dateFormat = withFormat
        self.locale = .current        
    }
    
}
