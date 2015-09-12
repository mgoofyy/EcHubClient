//
//  SelectViewController.swift
//  ecHome
//
//  Created by ecJon on 15/3/7.
//  Copyright (c) 2015年 ihat_studio. All rights reserved.
//

import UIKit


class SelectViewController: BaseViewController {

    @IBOutlet weak var envButton: UIButton!
    @IBOutlet weak var envCtlButton: UIButton!
    //@IBOutlet weak var downlButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(envButton)
        self.view.addSubview(envCtlButton)
        
        //self.view.addSubview(downlButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
