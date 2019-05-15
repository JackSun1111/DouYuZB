//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/12.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

@objcMembers class AnchorGroup: NSObject {
    //显示的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //显示的标题
    var tag_name : String = ""
    //显示的图标
    var icon_name : String = "home_header_normal"
    //添加游戏对应的图标
    var icon_url : String = ""
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()

    override init() {
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String: NSObject]] {
//                for dict in dataArray {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//    }

}
