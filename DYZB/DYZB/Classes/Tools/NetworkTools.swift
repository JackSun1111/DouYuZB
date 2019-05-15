//
//  NetworkTools.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/11.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : String]? = nil, finishedCallback : @escaping (_ result : AnyObject) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method:method, parameters:parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            finishedCallback(result as AnyObject)
            
        }
    }
}
