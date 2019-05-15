//
//  CommendViewModel.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/12.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    
    //请求推荐数据
    func requestData(finishedCallback : @escaping () -> ()) {
        
        let parameters = ["time":NSDate.getCurrentTime(),"limit":"4","offset":"0"]
        
        //创建group
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        //1.请求推荐数据
        
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //遍历字典，转成模型对象
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            //离开组
            dGroup.leave()
        }
        
        //2.请求颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1555040054
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //遍历字典，转成模型对象
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //离开组
            dGroup.leave()
        }
        
        
        //3.请求后面部分的游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1555040054
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                print(group.tag_name)
            }
            
            //离开组
            dGroup.leave()
        }
        
        //所有数据都请求到之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
    }
    
    //请求无限轮播数据
    func requestCycleData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            //获取字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            //根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //字典模型转对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
