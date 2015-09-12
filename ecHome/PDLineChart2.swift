//
//  PDLineChartDataItem.swift
//  ecHome
//
//  Created by goofygao on 15/3/13.
//  Copyright (c) 2015年 ihat_studio. All rights reserved.
//
//
//  PDLineChart.swift
//  Swift_iPhone_demo
//
//  Created by Pandara on 14-7-3.
//  Copyright (c) 2014年 Pandara. All rights reserved.
//

import UIKit
import QuartzCore

class PDLineChartDataItem2 {
    
    var chartLayerColor: UIColor = UIColor.whiteColor()
    
    var showAxes: Bool = true
    
    var xAxesDegreeTexts: [String]?
    var yAxesDegreeTexts: [String]?
    
    //require
    var xMax: CGFloat!
    var xInterval: CGFloat!
    
    var yMax: CGFloat!
    var yInterval: CGFloat!
    
    var pointArray: [CGPoint]?
    init() {
        
    }
}

class PDLineChart2: PDChart2 {
    var axesComponent: PDChartAxesComponent2!
    var dataItem2: PDLineChartDataItem2!
    
    init(frame: CGRect, dataItem2: PDLineChartDataItem2) {
        super.init(frame: frame)
        
        self.dataItem2 = dataItem2
        
        var axesDataItem: PDChartAxesComponentDataItem2 = PDChartAxesComponentDataItem2()
        axesDataItem.targetView = self
        axesDataItem.featureH = self.getFeatureHeight()
        axesDataItem.featureW = self.getFeatureWidth()
        axesDataItem.xMax = dataItem2.xMax
        axesDataItem.xInterval = dataItem2.xInterval
        axesDataItem.yMax = dataItem2.yMax
        axesDataItem.yInterval = dataItem2.yInterval
        axesDataItem.xAxesDegreeTexts = dataItem2.xAxesDegreeTexts
        axesDataItem.yAxesDegreeTexts = dataItem2.yAxesDegreeTexts
        
        axesComponent = PDChartAxesComponent2(dataItem2: axesDataItem)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getFeatureWidth() -> CGFloat {
        return CGFloat(self.frame.size.width)
    }
    
    func getFeatureHeight() -> CGFloat {
        return CGFloat(self.frame.size.height)
    }
    
    override func strokeChart() {
        if !(self.dataItem2.pointArray != nil) {
            return
        }
        
  
        var chartLayer: CAShapeLayer = CAShapeLayer()
        chartLayer.lineCap = kCALineCapRound
        chartLayer.lineJoin = kCALineJoinRound
        chartLayer.fillColor = UIColor.clearColor().CGColor
        chartLayer.strokeColor = UIColor.redColor().CGColor
        chartLayer.strokeColor = self.dataItem2.chartLayerColor.CGColor
        chartLayer.lineWidth = 2.0
        chartLayer.strokeStart = 0.0
        chartLayer.strokeEnd = 1.0
        self.layer.addSublayer(chartLayer)
        
  
        UIGraphicsBeginImageContext(self.frame.size)
        
        var progressLine: UIBezierPath = UIBezierPath()
        
        var basePoint: CGPoint = axesComponent.getBasePoint()
        var xAxesWidth: CGFloat = axesComponent.getXAxesWidth()
        var yAxesHeight: CGFloat = axesComponent.getYAxesHeight()
        for var i = 0; i < self.dataItem2.pointArray!.count; i++ {
            var point: CGPoint = self.dataItem2.pointArray![i]
            println("------\(self.dataItem2.pointArray![i])")
            var pixelPoint: CGPoint = CGPoint(x: basePoint.x + point.x / self.dataItem2.xMax * xAxesWidth, y: basePoint.y - point.y / self.dataItem2.yMax * yAxesHeight)
            
            if i == 0 {
                progressLine.moveToPoint(pixelPoint)
            } else {
                progressLine.addLineToPoint(pixelPoint)
            }
        }
        
        progressLine.stroke()
        
        chartLayer.path = progressLine.CGPath
        
        CATransaction.flush()
        var pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        
        //func addAnimation(anim: CAAnimation!, forKey key: String!)
        chartLayer.addAnimation(pathAnimation, forKey: "strokeEndAnimation")
        
        
        //class func setCompletionBlock(block: (() -> Void)!)
        CATransaction.setCompletionBlock({
            () -> Void in
        })
        CATransaction.commit()
        
        UIGraphicsEndImageContext()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var context: CGContext = UIGraphicsGetCurrentContext()
        
        axesComponent.strokeAxes(context)
    }
}




















