//
//  CollectionNormalCell.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/11.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    // MARK: - 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    override var anchor : AnchorModel? {
        didSet{ // 属性监听器
            super.anchor = anchor
            
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
