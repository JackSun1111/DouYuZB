//
//  PageTitleView.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/4.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

// MARK: - 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

// MARK: - 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {

    
    // MARK: - 定义属性
    private var titles: [String]
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    // MARK: - 懒加载属性
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension PageTitleView {
    private func setupUI() {
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // MARK: - 添加title对应的label
        setupTitleLabels()
        
        // MARK: - 添加底部的线
        setupBottomMenuAndScrollView()
    }
    
    private func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0

        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let lableX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: lableX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomMenuAndScrollView() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        scrollView.addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        
        //获取当前label的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        if currentLabel.tag == currentIndex { return }
        
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        //切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        //滚动条滚动
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

// MARK: - 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //取出sourceLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //处理颜色的渐变
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0*progress, g: kSelectColor.1 - colorDelta.1*progress, b: kSelectColor.2 - colorDelta.2*progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0*progress, g: kNormalColor.1 + colorDelta.1*progress, b: kNormalColor.2 + colorDelta.2*progress)
        
       //记录最新的index
        currentIndex = targetIndex
        
    }
}
