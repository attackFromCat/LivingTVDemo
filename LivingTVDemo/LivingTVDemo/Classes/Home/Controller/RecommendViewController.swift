//
//  RecommendViewController.swift
//  LivingTVDemo
//
//  Created by 李翔 on 2017/1/9.
//  Copyright © 2017年 Lee Xiang. All rights reserved.
//

import UIKit

// MARK: - 基本常量
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kHeaderHeight : CGFloat = 50

fileprivate let kNormalItemW : CGFloat = (kScreenW - 3 * kItemMargin) * 0.5
fileprivate let kNormalItemH : CGFloat = (kNormalItemW * 3) / 4
fileprivate let kPretyItemH = kNormalItemW * 4 / 3

fileprivate let KNormalCellID : String = "KNormalCellID"
fileprivate let KPretyCellID  : String = "KPretyCellID"
fileprivate let KHeaderViewID : String = "KHeaderViewID"

class RecommendViewController: UIViewController {

    /*
     在 Swift 中除了 weak 以外，还有另一个冲着编译器叫喊着类似的 "不要引用我" 的标识符，那就是 unowned 。它们的区别在哪里呢？如果您是一直写 Objective-C 过来的，那么从表面的行为上来说 unowned 更像以前的 unsafe_unretained ，而 weak 就是以前的 weak 。用通俗的话说，就是 unowned设置以后即使它原来引用的内容已经被释放了，它仍然会保持对被已经释放了的对象的一个 "无效的" 引用，它不能是 Optional 值，也不会被指向 nil 。如果你尝试调用这个引用的方法或者访问成员属性的话，程序就会崩溃。而 weak 则友好一些，在引用的内容被释放后，标记为 weak 的成员将会自动地变成 nil (因此被标记为 @weak 的变量一定需要是 Optional 值)。关于两者使用的选择，Apple 给我们的建议是如果能够确定在访问时不会已被释放的话，尽量使用 unowned ，如果存在被释放的可能，那就选择用 weak 。
     */
    
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 设置流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderHeight)
        
        // collectionView基本设置
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:
            layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionPretyCell", bundle: nil), forCellWithReuseIdentifier: KPretyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension RecommendViewController {
    
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPretyCellID, for: indexPath)
        }else{
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewID, for: indexPath)
    
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPretyItemH)
        }else{
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
        
    }
    
    
}
