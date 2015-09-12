
import UIKit



class CustomCtlViewController: BaseViewController {
    

    var ipFileAdress = NSHomeDirectory() + "/Documents/ip.txt"
    var ipAdressss:String!
    var userInfo:String!
    var menuButton = UIButton()
    var upButton = UIButton()
    var downButton = UIButton()
    var leftButton = UIButton()
    var rightButton = UIButton()
    
    var upButtonValue : String!
    var downButtonValue : String!
    var menuButtonValue : String!
    var rightButtonValue : String!
    var leftButtonValue : String!
    var learnFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var str:NSString = NSString(contentsOfFile: ipFileAdress, encoding: NSUTF8StringEncoding, error: nil)!
        var userInfoArray = str.componentsSeparatedByString("%")
        ipAdressss = userInfoArray[0] as! String
        userInfo = userInfoArray[1] as! String
        var buttonBackGround = UIImageView()
        buttonBackGround.frame = CGRect(x: self.sumWidth/6, y: self.sumHeight/4, width: self.sumWidth*2/3, height: self.sumWidth*2/3)
        buttonBackGround.image = UIImage(named: "platform.png")
        self.view.addSubview(buttonBackGround)
        
       
        menuButton.frame = CGRect(x: self.sumWidth/3, y: self.sumHeight/4 + self.sumWidth/6, width: self.sumWidth/3, height: self.sumWidth/3)
        menuButton.setImage(UIImage(named: "menu.png"), forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "MenuButtonClick", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(menuButton)
        
        
        upButton.frame = CGRect(x: self.sumWidth/2 - self.sumWidth/18, y: (self.sumHeight/2 + self.sumWidth/6)/2 - self.sumWidth/18, width: self.sumWidth/9, height: self.sumWidth/9)
        upButton.setImage(UIImage(named: "select_up.png"), forState: UIControlState.Normal)
        upButton.addTarget(self, action: "upButtonClick", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(upButton)
        
        
        downButton.frame = CGRect(x: self.sumWidth/2 - self.sumWidth/18, y: self.sumHeight/4 + self.sumWidth*19/36, width: self.sumWidth/9, height: self.sumWidth/9)
        downButton.setImage(UIImage(named: "select_down.png"), forState: UIControlState.Normal)
        downButton.addTarget(self, action: "downButtonClick", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(downButton)
        
        
        leftButton.frame = CGRect(x: self.sumWidth*7/36, y: self.sumHeight/4 + self.sumWidth*5/18, width: self.sumWidth/9, height: self.sumWidth/9)
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "leftButtonClick", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(leftButton)
        
        
        rightButton.frame = CGRect(x: self.sumWidth*25/36, y: self.sumHeight/4 + self.sumWidth*5/18, width: self.sumWidth/9, height: self.sumWidth/9)
        rightButton.setImage(UIImage(named: "right.png"), forState: UIControlState.Normal)
        rightButton.addTarget(self, action: "rightButtonClick", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(rightButton)
        
        var plusBackGround = UIImageView()
        plusBackGround.frame = CGRect(x: self.sumWidth*9/12, y: self.sumHeight/6, width: self.sumHeight/12, height: sumHeight/12)
        plusBackGround.image = UIImage(named: "platform.png")
        self.view.addSubview(plusBackGround)
        
        var plusButton = UIButton()
        plusButton.frame = CGRect(x: self.sumWidth*9/12 + self.sumHeight/48, y: self.sumHeight/6 + self.sumHeight/48, width: self.sumHeight/24, height: sumHeight/24)
        plusButton.setImage(UIImage(named: "plus.png"), forState: UIControlState.Normal)
        plusButton.addTarget(self, action: "plusButtonAction", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(plusButton)
        
        var turnONButton = UIButton()
        turnONButton.frame = CGRect(x: self.sumWidth/5, y: self.sumHeight * 2/3, width: 50 , height: 20)
        turnONButton.setTitle("ON", forState: UIControlState.Normal)
        turnONButton.titleLabel?.textColor = UIColor.whiteColor()
        turnONButton.addTarget(self, action: "turnONEvent", forControlEvents:UIControlEvents.TouchDown )
        self.view.addSubview(turnONButton)
        
        var turnOFFButton = UIButton()
        turnOFFButton.frame = CGRect(x: self.sumWidth*4/5 - 20, y: self.sumHeight * 2/3, width: 50, height: 20)
        turnOFFButton.setTitle("OFF", forState: UIControlState.Normal)
        turnOFFButton.titleLabel?.textColor = UIColor.whiteColor()
        turnOFFButton.addTarget(self, action: "turnOffEvent", forControlEvents:UIControlEvents.TouchDown )
        self.view.addSubview(turnOFFButton)
        
        var LearnButton = UIButton()
        LearnButton.frame = CGRect(x: self.sumWidth/5, y: self.sumHeight * 3/4, width: 50 , height: 20)
        LearnButton.setTitle("學習", forState: UIControlState.Normal)
        LearnButton.titleLabel?.textColor = UIColor.whiteColor()
        LearnButton.addTarget(self, action: "LearnEvent", forControlEvents:UIControlEvents.TouchDown )
        self.view.addSubview(LearnButton)
        
        var SendButton = UIButton()
        SendButton.frame = CGRect(x: self.sumWidth*4/5 - 20, y: self.sumHeight * 3/4, width: 50, height: 20)
        SendButton.setTitle("發送", forState: UIControlState.Normal)
        SendButton.titleLabel?.textColor = UIColor.whiteColor()
        SendButton.addTarget(self, action: "sendEvent", forControlEvents:UIControlEvents.TouchDown )
        
        self.view.addSubview(SendButton)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func turnONEvent(){
        
            var client = TCPClient(addr: ipAdressss, port: 9999)
            client.connect(timeout: 1)
            let (string1,string2) = client.send(str: userInfo)
            println(string1)
            client.send(str: "0")
      
        
    }
    
    func turnOffEvent(){
        
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println(string1)
        client.send(str: "1")
        
    }
    
    func LearnEvent(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        
        client.send(str: "r")
        
        
    }
    
    func sendEvent(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        client.send(str: "s")
    
    }
    func MenuButtonClick(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println(string1)
        client.send(str: "7")
        
    }
    func upButtonClick(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println("\(string1)")
        client.send(str: "3")
        
        
    }
    func downButtonClick(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println("\(string1)")
        client.send(str: "4")
     
        
    }
    func leftButtonClick(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println("\(string1)")
        client.send(str: "5")
       
        
    }
    func rightButtonClick(){
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println("\(string1)")
        client.send(str: "6")
   
    }

    func plusButtonAction()
    {
        var client = TCPClient(addr: ipAdressss, port: 9999)
        client.connect(timeout: 1)
        let (string1,string2) = client.send(str: userInfo)
        println("\(string1)")
        client.send(str: "8")
        
    }
    

    
}









