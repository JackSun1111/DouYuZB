//
//  MainViewController.swift
//  DYZB
//
//  Created by Jacksun on 2019/4/4.
//  Copyright © 2019 Jacksun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(stroyName: "Home")
        addChildVC(stroyName: "Live")
        addChildVC(stroyName: "Follow")
        addChildVC(stroyName: "Profile")
        
        // Do any additional setup after loading the view.
    }
    

    private func addChildVC(stroyName: String) {
        //通过sb获取控制器
        let childVC = UIStoryboard(name: stroyName, bundle: nil).instantiateInitialViewController()!
        
        //将childVC作为子控制器
        addChild(childVC)
    }

}
