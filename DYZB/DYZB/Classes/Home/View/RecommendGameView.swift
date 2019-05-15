//
//  RecommendGameView.swift
//  DYZB
//
//  Created by Jacksun on 2019/5/15.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMagin : CGFloat = 10

class RecommendGameView: UIView {
    
    //定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            
            //移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            
            collectionView.reloadData()
        }
    }
    
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //移除auto
        autoresizingMask = .flexibleBottomMargin
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //给collection添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMagin, bottom: 0, right: kEdgeInsetMagin)
    }
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        
        cell.group = groups![indexPath.item]
        
        
        return cell
    }
}
