//
//  PageContentView.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func scrollViewDrewing(_ pageContentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    // MARK: - 属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var beginOffsetX : CGFloat = 0
    fileprivate var isTitleViewTap :Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        
        // 设置flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = (self?.bounds.size)!
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView{
    
    fileprivate func setupUI() {
        
        // 将所有的子控制器加入到父控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        
        // 添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}

// MARK: - 提供给外界的方法
extension PageContentView {
    func setCurrentIndex(_ currentIndex : Int) {
        
        // 点击进来的就不让其滚动计算
        isTitleViewTap = true
        
        // 滚动到正确的位置
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offSetX, y : 0), animated: false)
        
    }
}

// MARK: - UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.addSubview(childVc.view)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isTitleViewTap = false
        beginOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 判断是否是点击事件
        if isTitleViewTap { return }
        
        // 定义所要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        // 判断是左滑还是右滑
        let value = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
        
        if currentOffsetX > beginOffsetX { // 左滑
            // 拖动百分比
            progress = value
            // 源目标
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 计算target
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 完全滑动过去
            if currentOffsetX - beginOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            
            progress = 1 - value
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        // 将计算的值传出
        delegate?.scrollViewDrewing(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}
