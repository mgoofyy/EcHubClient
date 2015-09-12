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

class PDLineChartDataItem {
  
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

class PDLineChart: PDChart {
    var axesComponent: PDChartAxesComponent!
    var dataItem: PDLineChartDataItem!
    
    init(frame: CGRect, dataItem: PDLineChartDataItem) {
        super.init(frame: frame)
        
        self.dataItem = dataItem
        
        var axesDataItem: PDChartAxesComponentDataItem = PDChartAxesComponentDataItem()
        axesDataItem.targetView = self
        axesDataItem.featureH = self.getFeatureHeight()
        axesDataItem.featureW = self.getFeatureWidth()
        axesDataItem.xMax = dataItem.xMax
        axesDataItem.xInterval = dataItem.xInterval
        axesDataItem.yMax = dataItem.yMax
        axesDataItem.yInterval = dataItem.yInterval
        axesDataItem.xAxesDegreeTexts = dataItem.xAxesDegreeTexts
        axesDataItem.yAxesDegreeTexts = dataItem.yAxesDegreeTexts
        
        axesComponent = PDChartAxesComponent(dataItem: axesDataItem)
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
        if !(self.dataItem.pointArray != nil) {
            return
        }
        
       
        var chartLayer: CAShapeLayer = CAShapeLayer()
        chartLayer.lineCap = kCALineCapRound
        chartLayer.lineJoin = kCALineJoinRound
        chartLayer.fillColor = UIColor.clearColor().CGColor
        chartLayer.strokeColor = self.dataItem.chartLayerColor.CGColor
        chartLayer.lineWidth = 2.0
        chartLayer.strokeStart = 0.0
        chartLayer.strokeEnd = 1.0
        self.layer.addSublayer(chartLayer)
        
       
        UIGraphicsBeginImageContext(self.frame.size)
        
        var progressLine: UIBezierPath = UIBezierPath()
        
        var basePoint: CGPoint = axesComponent.getBasePoint()
        var xAxesWidth: CGFloat = axesComponent.getXAxesWidth()
        var yAxesHeight: CGFloat = axesComponent.getYAxesHeight()
        for var i = 0; i < self.dataItem.pointArray!.count; i++ {
            var point: CGPoint = self.dataItem.pointArray![i]
            println("------\(self.dataItem.pointArray![i])")
            var pixelPoint: CGPoint = CGPoint(x: basePoint.x + point.x / self.dataItem.xMax * xAxesWidth, y: basePoint.y - point.y / self.dataItem.yMax * yAxesHeight)
            
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
        //pathAnimation.fromValue = 0.0
        //pathAnimation.toValue = 1.0
        
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




















