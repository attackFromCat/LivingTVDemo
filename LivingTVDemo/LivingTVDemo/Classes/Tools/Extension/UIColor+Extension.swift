//
//  UIColor+Extension.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/10.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat) {
        
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    
}
