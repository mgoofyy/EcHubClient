//
//  BaseNavigationController.swift
//  ecHome
//
//  Created by ecJon on 15/3/7.
//  Copyright (c) 2015年 ihat_studio. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(named: "bar2.png"), forBarMetrics: UIBarMetrics.Default)
        self.navigationBar.barStyle = UIBarStyle.Black
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
