//
//  PageTitleView.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

fileprivate let kTitleUnderlineH : CGFloat = 2

class PageTitleView: UIView {

    // MARK: - 属性
    fileprivate var titles : [String]
    
    // MARK: - 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    
    fileprivate func setUI() {
        // 添加滚动视图
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加滚动视图上面的label
        createTitleLabers()
        
        //设置底部分界线和滚动线条
        createTitleUnderLine()
    }
    
    fileprivate func createTitleLabers() {
        
        let titleLabelW : CGFloat = frame.width / CGFloat(titles.count)
        let titleLabelH : CGFloat = frame.height - kTitleUnderlineH
        let titleLabelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.text = title
            label.tag = index
            label.textColor = UIColor.black
            
            let titleLabelX : CGFloat = CGFloat(index) * titleLabelW
            label.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            
            scrollView.addSubview(label)
            // 保存创建的label
            titleLabels.append(label)
        }
    }
    
    fileprivate func createTitleUnderLine() {
        
        // 标题模块与滑动内容的分界线
        let DividingLine = UIView()
        let lineH : CGFloat = 0.5
        DividingLine.backgroundColor = UIColor.lightGray
        DividingLine.frame = CGRect(x: 0, y: frame.height - lineH, width: scrollView.frame.width, height: lineH)
        scrollView.addSubview(DividingLine)
        
        // 滚动滑块
        let titleUnderLine = UIView()
        guard let fristBtn = titleLabels.first else {return}
        titleUnderLine.frame = CGRect(x: 0, y: frame.height - kTitleUnderlineH, width: fristBtn.frame.width, height: kTitleUnderlineH)
        titleUnderLine.backgroundColor = UIColor.orange
        scrollView.addSubview(titleUnderLine)
    }
    
}
