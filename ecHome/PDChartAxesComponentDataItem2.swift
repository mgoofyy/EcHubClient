import UIKit

class PDChartAxesComponentDataItem2: NSObject {
    //required
    var targetView: UIView!
    
    var featureH: CGFloat!
    var featureW: CGFloat!
    
    var xMax: CGFloat!
    var xInterval: CGFloat!
    var yMax: CGFloat!
    var yInterval: CGFloat!
    
    var xAxesDegreeTexts: [String]?
    var yAxesDegreeTexts: [String]?
    
    //optional default
    var showAxes: Bool = true
    
    var showXDegree: Bool = true
    var showYDegree: Bool = true
    
    var axesColor: UIColor = UIColor.whiteColor()
    var axesTipColor: UIColor = UIColor.whiteColor()
    
    var xAxesLeftMargin: CGFloat = 40
    var xAxesRightMargin: CGFloat = 40
    var yAxesBottomMargin: CGFloat = 40
    var yAxesTopMargin: CGFloat = 40
    
    var axesWidth: CGFloat = 2.0
    
    var arrowHeight: CGFloat = 5.0
    var arrowWidth: CGFloat = 5.0
    var arrowBodyLength: CGFloat = 10.0
    
    var degreeLength: CGFloat = 5.0         
    var degreeTipFontSize: CGFloat = 10.0
    var degreeTipMarginHorizon: CGFloat = 5.0
    var degreeTipMarginVertical: CGFloat = 5.0
    
    override init() {
        
    }
}

class PDChartAxesComponent2: NSObject {
    
    var dataItem2: PDChartAxesComponentDataItem2!
    
    init(dataItem2: PDChartAxesComponentDataItem2) {
        self.dataItem2 = dataItem2
    }
    
    func getYAxesHeight() -> CGFloat {
        var basePoint: CGPoint = self.getBasePoint()
        var yAxesHeight = basePoint.y - dataItem2.arrowHeight - dataItem2.yAxesTopMargin - dataItem2.arrowBodyLength
        return yAxesHeight
    }
    
    func getXAxesWidth() -> CGFloat {//width between 0~xMax
        var basePoint: CGPoint = self.getBasePoint()
        var xAxesWidth = dataItem2.featureW - basePoint.x - dataItem2.arrowHeight - dataItem2.xAxesRightMargin - dataItem2.arrowBodyLength
        return xAxesWidth
    }
    
    func getBasePoint() -> CGPoint {
        
        var neededAxesWidth: CGFloat!
        if dataItem2.showAxes {
            neededAxesWidth = CGFloat(dataItem2.axesWidth)
        } else {
            neededAxesWidth = 0
        }
        
        var basePoint: CGPoint = CGPoint(x: dataItem2.xAxesLeftMargin + neededAxesWidth / 2.0, y: dataItem2.featureH - (dataItem2.yAxesBottomMargin + neededAxesWidth / 2.0))
        return basePoint
    }
    
    func getXDegreeInterval() -> CGFloat {
        var xAxesWidth: CGFloat = self.getXAxesWidth()
        var xDegreeInterval: CGFloat = dataItem2.xInterval / dataItem2.xMax * xAxesWidth
        return xDegreeInterval
    }
    
    func getYDegreeInterval() -> CGFloat {
        var yAxesHeight: CGFloat = self.getYAxesHeight()
        var yDegreeInterval: CGFloat = dataItem2.yInterval / dataItem2.yMax * yAxesHeight
        return yDegreeInterval
    }
    
    func getAxesDegreeTipLabel(tipText: String, center: CGPoint, size: CGSize, fontSize: CGFloat, textAlignment: NSTextAlignment, textColor: UIColor) -> UILabel {
        var label: UILabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        label.text = tipText
        label.center = center
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.backgroundColor = UIColor.clearColor()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
    }
    
    func getXAxesDegreeTipLabel(tipText: String, center: CGPoint, size: CGSize, fontSize: CGFloat) -> UILabel {
        return self.getAxesDegreeTipLabel(tipText, center: center, size: size, fontSize: fontSize, textAlignment: NSTextAlignment.Center, textColor: dataItem2.axesTipColor)
    }
    
    func getYAxesDegreeTipLabel(tipText: String, center: CGPoint, size: CGSize, fontSize: CGFloat) -> UILabel {
        return self.getAxesDegreeTipLabel(tipText, center: center, size: size, fontSize: fontSize, textAlignment: NSTextAlignment.Right, textColor: dataItem2.axesTipColor)
    }
    
    func strokeAxes(context: CGContextRef?) {
        var xAxesWidth: CGFloat = self.getXAxesWidth()
        var yAxesHeight: CGFloat = self.getYAxesHeight()
        var basePoint: CGPoint = self.getBasePoint()
        
        
        if dataItem2.showAxes {
            CGContextSetStrokeColorWithColor(context, dataItem2.axesColor.CGColor)
            CGContextSetFillColorWithColor(context, dataItem2.axesColor.CGColor)
            
            var axesPath: UIBezierPath = UIBezierPath()
            axesPath.lineWidth = dataItem2.axesWidth
            axesPath.lineCapStyle = kCGLineCapRound
            axesPath.lineJoinStyle = kCGLineJoinRound
            
            //x axes--------------------------------------
            axesPath.moveToPoint(CGPoint(x: basePoint.x, y: basePoint.y))
            axesPath.addLineToPoint(CGPoint(x: basePoint.x + xAxesWidth, y: basePoint.y))
            
            //degrees in x axes
            var xDegreeNum: Int = Int((dataItem2.xMax - (dataItem2.xMax % dataItem2.xInterval)) / dataItem2.xInterval)
            var xDegreeInterval: CGFloat = self.getXDegreeInterval()
            
            if dataItem2.showXDegree {
                for var i = 0; i < xDegreeNum; i++ {
                    var degreeX: CGFloat = basePoint.x + xDegreeInterval * CGFloat(i + 1)
                    axesPath.moveToPoint(CGPoint(x: degreeX, y: basePoint.y))
                    axesPath.addLineToPoint(CGPoint(x: degreeX, y: basePoint.y - dataItem2.degreeLength))
                }
            }
            
            //x axes arrow
            //arrow body
            axesPath.moveToPoint(CGPoint(x: basePoint.x + xAxesWidth, y: basePoint.y))
            axesPath.addLineToPoint(CGPoint(x: basePoint.x + xAxesWidth + dataItem2.arrowBodyLength, y: basePoint.y))
            //arrow head
            var arrowPath: UIBezierPath = UIBezierPath()
            arrowPath.lineWidth = dataItem2.axesWidth
            arrowPath.lineCapStyle = kCGLineCapRound
            arrowPath.lineJoinStyle = kCGLineJoinRound
            
            var xArrowTopPoint: CGPoint = CGPoint(x: basePoint.x + xAxesWidth + dataItem2.arrowBodyLength + dataItem2.arrowHeight, y: basePoint.y)
            arrowPath.moveToPoint(xArrowTopPoint)
            arrowPath.addLineToPoint(CGPoint(x: basePoint.x + xAxesWidth + dataItem2.arrowBodyLength, y: basePoint.y - dataItem2.arrowWidth / 2))
            arrowPath.addLineToPoint(CGPoint(x: basePoint.x + xAxesWidth + dataItem2.arrowBodyLength, y: basePoint.y + dataItem2.arrowWidth / 2))
            arrowPath.addLineToPoint(xArrowTopPoint)
            
            //y axes--------------------------------------
            axesPath.moveToPoint(CGPoint(x: basePoint.x, y: basePoint.y))
            axesPath.addLineToPoint(CGPoint(x: basePoint.x, y: basePoint.y - yAxesHeight))
            
            //degrees in y axes
            var yDegreesNum: Int = Int((dataItem2.yMax - (dataItem2.yMax % dataItem2.yInterval)) / dataItem2.yInterval)
            var yDegreeInterval: CGFloat = self.getYDegreeInterval()
            if dataItem2.showYDegree {
                for var i = 0; i < yDegreesNum; i++ {
                    var degreeY: CGFloat = basePoint.y - yDegreeInterval * CGFloat(i + 1)
                    axesPath.moveToPoint(CGPoint(x: basePoint.x, y: degreeY))
                    axesPath.addLineToPoint(CGPoint(x: basePoint.x +  dataItem2.degreeLength, y: degreeY))
                }
            }
            
            //y axes arrow
            //arrow body
            axesPath.moveToPoint(CGPoint(x: basePoint.x, y: basePoint.y - yAxesHeight))
            axesPath.addLineToPoint(CGPoint(x: basePoint.x, y: basePoint.y - yAxesHeight - dataItem2.arrowBodyLength))
            //arrow head
            var yArrowTopPoint: CGPoint = CGPoint(x: basePoint.x, y: basePoint.y - yAxesHeight - dataItem2.arrowBodyLength - dataItem2.arrowHeight)
            arrowPath.moveToPoint(yArrowTopPoint)
            arrowPath.addLineToPoint(CGPoint(x: basePoint.x - dataItem2.arrowWidth / 2, y: basePoint.y - yAxesHeight - dataItem2.arrowBodyLength))
            arrowPath.addLineToPoint(CGPoint(x: basePoint.x + dataItem2.arrowWidth / 2, y: basePoint.y - yAxesHeight - dataItem2.arrowBodyLength))
            arrowPath.addLineToPoint(yArrowTopPoint)
            
            axesPath.stroke()
            arrowPath.stroke()
            
            //axes tips------------------------------------
            //func getXAxesDegreeTipLabel(tipText: String, frame: CGRect, fontSize: CGFloat) -> UILabel {
            if (dataItem2.xAxesDegreeTexts != nil) {
                for var i = 0; i < dataItem2.xAxesDegreeTexts!.count; i++ {
                    var size: CGSize = CGSize(width: xDegreeInterval - dataItem2.degreeTipMarginHorizon * 2, height: dataItem2.degreeTipFontSize)
                    var center: CGPoint = CGPoint(x: basePoint.x + xDegreeInterval * CGFloat(i + 1), y: basePoint.y + dataItem2.degreeTipMarginVertical + size.height / 2)
                    var label: UILabel = self.getXAxesDegreeTipLabel(dataItem2.xAxesDegreeTexts![i], center: center, size: size, fontSize: dataItem2.degreeTipFontSize)
                    dataItem2.targetView.addSubview(label)
                }
            } else {
                for var i = 0; i < xDegreeNum; i++ {
                    var size: CGSize = CGSize(width: xDegreeInterval - dataItem2.degreeTipMarginHorizon * 2, height: dataItem2.degreeTipFontSize)
                    var center: CGPoint = CGPoint(x: basePoint.x + xDegreeInterval * CGFloat(i + 1), y: basePoint.y + dataItem2.degreeTipMarginVertical + size.height / 2)
                    var label: UILabel = self.getXAxesDegreeTipLabel("\(CGFloat(i + 1) * dataItem2.xInterval)", center: center, size: size, fontSize: dataItem2.degreeTipFontSize)
                    dataItem2.targetView.addSubview(label)
                }
            }
            
            if (dataItem2.yAxesDegreeTexts != nil) {
                for var i = 0; i < dataItem2.yAxesDegreeTexts!.count; i++ {
                    var size: CGSize = CGSize(width: dataItem2.xAxesLeftMargin - dataItem2.degreeTipMarginHorizon * 2, height: dataItem2.degreeTipFontSize)
                    var center: CGPoint = CGPoint(x: dataItem2.xAxesLeftMargin / 2, y: basePoint.y - yDegreeInterval * CGFloat(i + 1))
                    var label: UILabel = self.getYAxesDegreeTipLabel(dataItem2.yAxesDegreeTexts![i], center: center, size: size, fontSize: dataItem2.degreeTipFontSize)
                    dataItem2.targetView.addSubview(label)
                }
            } else {
                for var i = 0; i < yDegreesNum; i++ {
                    var size: CGSize = CGSize(width: dataItem2.xAxesLeftMargin - dataItem2.degreeTipMarginHorizon * 2, height: dataItem2.degreeTipFontSize)
                    var center: CGPoint = CGPoint(x: dataItem2.xAxesLeftMargin / 2, y: basePoint.y - yDegreeInterval * CGFloat(i + 1))
                    var label: UILabel = self.getYAxesDegreeTipLabel("\(CGFloat(i + 1) * dataItem2.yInterval)", center: center, size: size, fontSize: dataItem2.degreeTipFontSize)
                    //dataItem.targetView.addSubview(label)
                }
            }
        }
        
    }
}
