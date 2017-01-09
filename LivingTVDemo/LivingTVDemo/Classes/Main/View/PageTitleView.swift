//
//  PageTitleView.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

// MARK: - 代理协议
protocol PageTitleViewDelegate : class {
    func titleLabelClick(_ titleView : PageTitleView, selectedIndex : Int)
}

// MARK: - 定义常量
fileprivate let kTitleUnderlineH : CGFloat = 2
fileprivate let kNormalColor : (CGFloat ,CGFloat ,CGFloat) = (85, 85, 85)
fileprivate let kSelectedColor : (CGFloat ,CGFloat ,CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    // MARK: - 属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    // MARK: - 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var titleUnderLine :UIView = {
        let titleUnderLine = UIView()
        titleUnderLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1.0)
        return titleUnderLine
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
            
            let titleLabelX : CGFloat = CGFloat(index) * titleLabelW
            label.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            
            // 创建手势监听点击事件
            label.isUserInteractionEnabled = true
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelDidClick(_:)))
            label.addGestureRecognizer(tapGestrue)
            
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
        guard let fristBtn = titleLabels.first else {return}
        fristBtn.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1.0)
        titleUnderLine.frame = CGRect(x: 0, y: frame.height - kTitleUnderlineH, width: fristBtn.frame.width, height: kTitleUnderlineH)
        scrollView.addSubview(titleUnderLine)
    }
}

// MARK: - label的点击事件
extension PageTitleView {
    
    @objc func titleLabelDidClick(_ tapGest : UITapGestureRecognizer) {
        
        // 拿到选中的label
        guard let selectedLabel = tapGest.view as? UILabel else { return }
        
        let prelabel = titleLabels[currentIndex]
        
        // 变化颜色
        prelabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
        selectedLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2, alpha: 1.0)
        
        // 重新记录当前下标
        currentIndex = selectedLabel.tag
        
        // 滑动下划线
        let offSetX = CGFloat(currentIndex) * titleUnderLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.titleUnderLine.frame.origin.x = offSetX
        }
        
        // 代理传值
        delegate?.titleLabelClick(self, selectedIndex: currentIndex)
    }
}

// MARK: - 暴露的方法
extension PageTitleView {
    func setTitleStatus(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        // 取出要进行变化的两个label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 移动下划线
        let offSetX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let lineOffsetX = offSetX * progress
        titleUnderLine.frame.origin.x = sourceLabel.frame.origin.x + lineOffsetX
        
        // 改变标题的颜色
        // 取出颜色改变的范围
        let colorRange = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorRange.0 * progress, g: kSelectedColor.1 - colorRange.1 * progress, b: kSelectedColor.2 - colorRange.2 * progress, alpha: 1.0)
     
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorRange.0 * progress, g: kNormalColor.1 + colorRange.1 * progress, b: kNormalColor.2 + colorRange.2 * progress, alpha: 1.0)
        
        // 记录最新的下标值
        currentIndex = targetIndex
        
    }
}
