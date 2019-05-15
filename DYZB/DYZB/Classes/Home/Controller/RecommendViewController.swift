//
//  RecommendViewController.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/8.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3*kItemMargin)/2
private let kItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kHeaderCellID = "kHeaderCellID"
private let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: UIViewController {

    // MARK: - 懒加载
    private lazy var recommendVC : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderCellID)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendcycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
        
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        //发送网络请求
        loadData()

    }

}


//设置UI界面内容
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        //将gameview添加到collectionView中
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension RecommendViewController {
    private func loadData() {
        recommendVC.requestData {
            self.collectionView.reloadData()
            
            //将数据传递给gameView
            self.gameView.groups = self.recommendVC.anchorGroups
        }
        
        //请求轮播数据
        recommendVC.requestCycleData {
            self.cycleView.cycleModels = self.recommendVC.cycleModels
        }
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVC.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVC.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let group = recommendVC.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            cell.anchor = anchor
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            cell.anchor = anchor
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderCellID, for: indexPath) as! CollectionHeaderView
        
        //取出模型
        headerView.group = recommendVC.anchorGroups[indexPath.section]
        
        return headerView
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
            }
}
