//
//  MainTabBarController.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createViewController("Home", title: "首页", imageName: "btn_home_normal", selectedImageName: "btn_home_selected")
        createViewController("Living", title: "直播", imageName: "btn_live_normal", selectedImageName: "btn_live_selected")
        createViewController("Follow", title: "关注", imageName: "btn_column_normal", selectedImageName: "btn_column_selected")
        createViewController("Profile", title: "我的", imageName: "btn_user_normal", selectedImageName: "btn_user_selected")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    fileprivate func createViewController(_ storyName : String ,title : String, imageName : String, selectedImageName : String) {
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        childVc.tabBarItem.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        addChildViewController(childVc)
    }
}
