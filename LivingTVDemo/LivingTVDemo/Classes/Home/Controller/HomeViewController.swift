//
//  HomeViewController.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "手游", "娱乐", "趣玩"]
        let titleVeiw = PageTitleView(frame: titleFrame, titles: titles)
        titleVeiw.delegate = self
        return titleVeiw
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentViewF = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(PhoneGameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let contentView = PageContentView(frame: contentViewF, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension HomeViewController {
    
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        // 创建导航栏
        setupNavgationBar()
        
        // 添加标题导航条
        view.addSubview(pageTitleView)
        
        // 添加内容视图
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavgationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 35, height: 35)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, qrcodeItem, searchItem]
    }
    
}

// MARK: - PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func titleLabelClick(_ titleView: PageTitleView, selectedIndex: Int) {
        pageContentView.setCurrentIndex(selectedIndex)
    }
}

// MARK: - PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    
    func scrollViewDrewing(_ pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleStatus(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
