//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/9.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
    //定义模型属性
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            //取出在线人数显示的文字
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL  = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
            roomNameLabel.text = anchor.room_name
        }
    }
    
}
