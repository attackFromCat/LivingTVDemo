//
//  UIBarButtonItem.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String, highlightImageName : String = "", size : CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highlightImageName != "" {
            
            btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
    
    
    
}
