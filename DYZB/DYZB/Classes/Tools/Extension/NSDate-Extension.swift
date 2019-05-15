//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/12.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
        
    }
}
