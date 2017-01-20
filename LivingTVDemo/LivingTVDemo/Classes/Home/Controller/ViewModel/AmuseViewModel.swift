//
//  AmuseViewModel.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/20.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
