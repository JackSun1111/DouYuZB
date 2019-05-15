
//
//  AnchorModel.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/12.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

@objcMembers class AnchorModel: NSObject {

    var romm_id : Int = 0
    //房间图片对应的URL
    var vertical_src : String = ""
    //判断是手机直播还是电脑直播,0表示电脑直播，1表示手机直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //在线人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    
}
