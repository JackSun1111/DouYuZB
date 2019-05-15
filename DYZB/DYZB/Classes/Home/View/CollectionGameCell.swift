//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by Jacksun on 2019/5/15.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            let iconURL = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
}
