//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by Jacksun on 2019/5/14.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    // MARK: - 关联属性
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    //定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL)
        }
    }
    

}
