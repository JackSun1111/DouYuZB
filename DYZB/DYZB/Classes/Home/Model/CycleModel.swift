//
//  CycleModel.swift
//  DYZB
//
//  Created by Jacksun on 2019/5/7.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

@objcMembers class CycleModel: NSObject {
    //标题
    var title : String = ""
    //图片URL
    var pic_url : String = ""
    //主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息对应的模型对象
    var anchor : AnchorModel?
    
    //自定义构造函数
    init(dict : [String : NSObject]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        return
    }
    
}
