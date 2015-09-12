//
//  LoginViewController.swift
//  ecHome
//
//  Created by ecJon on 15/3/5.
//  Copyright (c) 2015年 ihat_studio. All rights reserved.
//

import UIKit


class LoginViewController: BaseViewController{


    @IBOutlet weak var loginButton: UIButton!
    var ipAdress = UITextField()
    var userName = UITextField()
    var passWord = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.sumHeight)
        var logoImage = UIImageView()
        logoImage.frame = CGRect(x: self.sumWidth/3, y: self.sumHeight/4, width: self.sumWidth/3, height: self.sumHeight/6)
        logoImage.image = UIImage(named: "logo.png")
        
        self.view.addSubview(logoImage)
        
        
        
        ipAdress.frame = CGRect(x: self.sumWidth/5, y: self.sumHeight * 2/3, width: self.sumWidth*3/5, height: 30)
        ipAdress.background = UIImage(named: "input.png")
        ipAdress.placeholder = " 請輸入主機IP"
       
        self.view.addSubview(ipAdress)

        
        
        userName.frame = CGRect(x: self.sumWidth/5, y: self.sumHeight/2, width: self.sumWidth*3/5, height: 30)
        userName.background = UIImage(named: "input.png")
        userName.placeholder = "請輸入用戶名"
        
        self.view.addSubview(userName)
        
        
        passWord.frame = CGRect(x: self.sumWidth/5, y: self.sumHeight/2+50, width: self.sumWidth*3/5, height: 30)
        passWord.background = UIImage(named: "input.png")
        passWord.secureTextEntry = true
        passWord.placeholder = " 請輸入用戶密碼"
        self.view.addSubview(passWord)
        

        loginButton.frame = CGRect(x: self.sumWidth*3/10, y: self.sumHeight/2+90, width: self.sumWidth/5, height: 30)
        loginButton.setTitle("登陸", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginButton.addTarget(self, action:"butClick:",forControlEvents:.TouchUpInside)
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func butClick(sender: UIButton){
       
        
         //shouldPerformSegueWithIdentifier("login", sender: self)
        var test = NSHomeDirectory() + "/Documents/ip.txt"
        var manger = NSFileManager.defaultManager()
        manger.createFileAtPath(test, contents: nil, attributes: nil)
        var contents = manger.contentsOfDirectoryAtPath(NSHomeDirectory()+"/Documents", error: nil)
        if userName.text == "ihat" || passWord.text == "ihat210ihat"
        {
            
       
         println("\(contents)")
        println("\(test)")
        var text:String = "\(ipAdress.text)" + "%" + "\(userName.text)" + "&" + "\(passWord.text)"
        println("\(text)")
        text.writeToFile(test, atomically: true, encoding: 1, error: nil)
        //
            //performSegueWithIdentifier("login", sender: self)
        //self.performSegueWithIdentifier("login", sender: self)
        }
        else {
            //self.performSegueWithIdentifier("login", sender: self)
            self.dismissViewControllerAnimated(false, completion: nil)
            let alert = UIAlertView()
            alert.title = "警告"
            alert.message = "用戶輸入信息有誤"
            alert.addButtonWithTitle("重新輸入")
            alert.show()
            
            
        }
        }
   
    
    
    @IBAction func logOut(segue: UIStoryboardSegue){
        
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
