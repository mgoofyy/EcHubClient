//
//  BaseViewController.swift
//  ecHome
//
//  Created by ecJon on 15/3/5.
//  Copyright (c) 2015年 ihat_studio. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var sumWidth = CGFloat()
    var sumHeight = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        var BackGroundImage = UIImageView()
        BackGroundImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        BackGroundImage.image = UIImage(named: "bg.png")
        self.view.addSubview(BackGroundImage)
        self.sumHeight = self.view.frame.height
        self.sumWidth = self.view.frame.width
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
