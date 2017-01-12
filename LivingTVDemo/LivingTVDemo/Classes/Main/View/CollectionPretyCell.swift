//
//  CollectionPretyCell.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/12.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

class CollectionPretyCell: CollectionBaseCell {

    @IBOutlet weak var locationBtn: UIButton!
    
    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            
            // 2.所在的城市
            locationBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
