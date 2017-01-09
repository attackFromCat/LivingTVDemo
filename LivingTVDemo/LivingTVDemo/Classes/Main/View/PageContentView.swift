//
//  PageContentView.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    // MARK: - 属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    
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
    
}
