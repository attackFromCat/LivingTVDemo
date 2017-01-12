//
//  NSDate+Extension.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/12.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

extension Date {
    
    static func getCurrentTimeInterval() -> String {
        
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
    
}
