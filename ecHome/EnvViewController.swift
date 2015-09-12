//
//  EnvViewController.swift
//  ecHome
//
//  Created by ecJon on 15/3/7.
//  Copyright (c) 2015年 ihat_studio. All rights reserved.
//


import UIKit

 class EnvViewController: BaseViewController  {
    
    var ipFileAdress = NSHomeDirectory() + "/Documents/ip.txt"
    var ipAdressss:String!
    var socketData:TCPClient!
    
    var dataItem: PDLineChartDataItem = PDLineChartDataItem()
    var dataItem2: PDLineChartDataItem2 = PDLineChartDataItem2()
    
    var humidityLineChart: PDLineChart!
    var temperatureLineChart : PDLineChart2!
    var time:NSTimer!
    var i:Int!
    var humidityLabel = UILabel()
    var temperatureLabel = UILabel()
    var array1 = [0,0,0,0,0,0,0]
    var array2 = [0,0,0,0,0,0,0]
    
    // deal With Data
    
    //var socketFormtArray = TCPClient.testtcpclient(<,#TCPClient#>)
    
        override func viewDidLoad() {
        super.viewDidLoad()
            i = 0
            time = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "drawline", userInfo: nil, repeats: true)
            
            
        }
    
        func drawline(){
            var str:NSString = NSString(contentsOfFile: ipFileAdress, encoding: NSUTF8StringEncoding, error: nil)!
            var string1 = str as! String
            var string2 = string1.componentsSeparatedByString("%")
            ipAdressss = string2[0]
            socketData = TCPClient(addr: ipAdressss, port: 9994)
            
        if(i == 1){
            
            humidityLineChart.removeFromSuperview()
            temperatureLineChart.removeFromSuperview()
            humidityLineChart = nil
            temperatureLineChart = nil
        }
            
            var temperatureData = socketData.testtcpclient()
            if temperatureData.isEmpty || temperatureData == "error" {
                println("wqqqwqwqwqw")
                temperatureData = "0&0"

            }
            var temperatureArray : [String] = temperatureData.componentsSeparatedByString("&")
            var num1 = temperatureArray[0].toInt()
            var num2 = temperatureArray[1].toInt()
         

            if num1 != nil && num2 != nil {
                array1.removeAtIndex(0)
                array1.append(num1!)
                println("\(array1)")
                array2.removeAtIndex(0)
                array2.append(num2!)
                println("\(array2)")
            }
            
//            else {
//                let alert = UIAlertView()
//                alert.title = "未接收到数据"
//                alert.message = "连接出错"
//                alert.addButtonWithTitle("重试")
//                //alert.targetForAction(<#action: Selector#>, withSender: <#AnyObject?#>)
//                alert.show()
//            }
       
            humidityLineChart = self.getLineHumidityChart()
            humidityLineChart.dataItem.pointArray =  [CGPoint(x: 1.0, y: CGFloat(array2[0])), CGPoint(x: 2.0, y: CGFloat(array2[1])), CGPoint(x: 3.0, y: CGFloat(array2[2])), CGPoint(x: 4.0, y:CGFloat(array2[3])), CGPoint(x: 5.0, y: CGFloat(array2[4])), CGPoint(x: 6.0, y: CGFloat(array2[5])), CGPoint(x: 7.0, y: CGFloat(array2[6]))]

            temperatureLineChart = self.getLinetemperatureChart()
            temperatureLineChart.dataItem2.pointArray = [CGPoint(x: 1.0, y: CGFloat(2*array1[0])), CGPoint(x: 2.0, y: CGFloat(2*array1[1])), CGPoint(x: 3.0, y: CGFloat(2*array1[2])), CGPoint(x: 4.0, y:CGFloat(2*array1[3])), CGPoint(x: 5.0, y: CGFloat(2*array1[4])), CGPoint(x: 6.0, y: CGFloat(2*array1[5])), CGPoint(x: 7.0, y: CGFloat(2*array1[6]))]
            
            humidityLabel.text = "湿度"
            temperatureLabel.text = "温度"
            humidityLabel.textColor = UIColor.whiteColor()
            temperatureLabel.textColor = UIColor.whiteColor()
            humidityLabel.frame = CGRect(x: (x: self.view.frame.width - 20)/2, y: 75, width: 40, height: 40)
            temperatureLabel.frame = CGRect(x: (x: self.view.frame.width - 20)/2, y: self.view.frame.height / 2 + 30, width: 40, height: 40)
            
            self.view.addSubview(temperatureLabel)
            self.view.addSubview(temperatureLineChart)
            self.view.addSubview(humidityLabel)
            self.view.addSubview(humidityLineChart)
        temperatureLineChart.strokeChart()
        humidityLineChart.strokeChart()
            
        i = 1
        }


    
     override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    func getLineHumidityChart() -> PDLineChart {
        println("1")
        dataItem.xMax = 7.0
        dataItem.xInterval = 1.0
        dataItem.yMax = 100.0
        dataItem.yInterval = 10.0
        dataItem.xAxesDegreeTexts = [ "1","2","3","4","5","6","7"]
        dataItem.yAxesDegreeTexts = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
        
        var lineChart: PDLineChart = PDLineChart(frame: CGRectMake(0, 50, self.view.frame.width, (self.view.frame.height - 30) / 2), dataItem: dataItem)
       
        return lineChart
    }
    func getLinetemperatureChart() -> PDLineChart2 {
        dataItem2.xMax = 7.0
        dataItem2.xInterval = 1.0
        dataItem2.yMax = 100.0
        dataItem2.yInterval = 10.0
        
        dataItem2.xAxesDegreeTexts = [ "1","2","3","4","5","6","7"]
        dataItem2.yAxesDegreeTexts = [ "5","10", "15", "20", "25", "30", "35", "40", "45", "50"]
    
        var lineChart: PDLineChart2 = PDLineChart2(frame: CGRectMake(0, (self.view.frame.height - 30)/2 + 20, self.view.frame.width, (self.view.frame.height - 30) / 2), dataItem2: dataItem2)
        
        return lineChart
    }


}