//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/29.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    // MARK: - 定义属性
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
            //设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定时器
            removeTimer()
            addCycleTimer()
        }
    }
    
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = .flexibleBottomMargin
        
        //注册cell
        
        collectionView.register(UINib.init(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }

}


extension RecommendCycleView {
    class func recommendcycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % (cycleModels?.count)!]
        
        
        return cell
    }
}

// MARK: - 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offSetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offSetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        addCycleTimer()
    }
}

extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc private func scrollToNext() {
        let currentOffSetX = collectionView.contentOffset.x
        let offsetX = currentOffSetX + collectionView.bounds.width
        
        //滚动位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
