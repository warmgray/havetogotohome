//
//  DrawMainGraphic.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class DrawMainGraphic: UIView {
    
    var startPoint: CGFloat = 0
    var color: UIColor = UIColor(red: 0, green: 146/255, blue: 70/255, alpha: 1.0)
    var trackColor: UIColor = UIColor.clear
    var trackWidth: CGFloat = 1
    var fillPercentage: CGFloat = 100
    var circleLayer: CAShapeLayer!
    var trafficInfo: String!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        circleLayer = CAShapeLayer()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clear
        
    } // init

    private func getGraphStartAndEndPointsInRadians() -> (graphStartingPoint: CGFloat, graphEndingPoint: CGFloat) {
        
        if ( 0 > self.startPoint ) {
            self.startPoint = 0
        } else if ( 100 < self.startPoint ) {
            self.startPoint = 100
        }
        
        
        if ( 0 > self.fillPercentage ) {
            self.fillPercentage = 0
        } else if ( 100 < self.fillPercentage ) {
            self.fillPercentage = 100
        }
        
        self.startPoint = self.startPoint - 25
        
        let trueFillPercentage = self.fillPercentage + self.startPoint
        
        let π: CGFloat = CGFloat(M_PI)
        
        // now we can calculate our start and end points in radians
        let startPoint: CGFloat = ((2 * π) / 100) * (CGFloat(self.startPoint))
        let endPoint: CGFloat = ((2 * π) / 100) * (CGFloat(trueFillPercentage))
        
        return(startPoint, endPoint)
        
    } // func
    
//    override func draw(_ rect: CGRect) {
//        
//        let center: CGPoint = CGPoint(x: self.frame.width/2, y: 221)
//        let radius: CGFloat = 106
//        
//        if ( 1 > self.trackWidth) {
//            self.trackWidth = 1
//        } // if
//        
//        if ( radius < self.trackWidth ) {
//            self.trackWidth = radius
//        } // if
//        
//        let (graphStartingPoint, graphEndingPoint) = self.getGraphStartAndEndPointsInRadians()
//        
//        let percentagePath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: graphStartingPoint, endAngle: graphEndingPoint, clockwise: true)
//        percentagePath.lineWidth = trackWidth
//        
//        self.color.setStroke()
//        
//        percentagePath.stroke()
//        
//        return
//        
//    } // func
    
    func makeCircleCALayer(dotCircleCenter:CGPoint, radius:CGFloat) {
        let center: CGPoint = dotCircleCenter
        let radius: CGFloat = radius
        let trafficInfoCenter: CGPoint!
        
        if ( 1 > self.trackWidth) {
            self.trackWidth = 1
        } // if
        
        if ( radius < self.trackWidth ) {
            self.trackWidth = radius
        } // if
        
        let (graphStartingPoint, graphEndingPoint) = self.getGraphStartAndEndPointsInRadians()
        
        let percentagePath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: graphStartingPoint, endAngle: graphEndingPoint, clockwise: true)
        let midPointAngle = (graphStartingPoint + graphEndingPoint)/2
        trafficInfoCenter = CGPoint(x: center.x + radius*cos(midPointAngle), y: center.y + radius*sin(midPointAngle))
        
        let trafficInfoLabel = UILabel(frame: CGRect(x: trafficInfoCenter.x - 15 , y: trafficInfoCenter.y - 7, width: 30, height: 14))
        let trafficInfoLayer = trafficInfoLabel.layer
        
        trafficInfoLabel.font = UIFont(name: "Montserrat-Bold", size: 10)
        trafficInfoLabel.text = trafficInfo
        trafficInfoLabel.textAlignment = .center
        trafficInfoLabel.textColor = color
        
        trafficInfoLayer.borderColor = color.cgColor
        trafficInfoLayer.borderWidth = 1.2
        trafficInfoLayer.cornerRadius = 5
        trafficInfoLayer.backgroundColor = UIColor(red: 18/255, green: 20/255, blue: 37/255, alpha: 1).cgColor
        trafficInfoLayer.masksToBounds = true
        
        circleLayer.path = percentagePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineWidth = trackWidth
        circleLayer.lineCap = kCALineCapRound
        circleLayer.strokeEnd = 0.0
        self.layer.addSublayer(circleLayer)
        self.addSubview(trafficInfoLabel)

    }
    
    func animateCircle(duration: TimeInterval) {
        
        CATransaction.begin()
        let animline = CABasicAnimation(keyPath: "strokeEnd")
        animline.fromValue         = 0
        animline.toValue           = 1
        animline.duration          = duration
        animline.timingFunction    = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.strokeEnd = 1.0
        circleLayer.add(animline, forKey: "animateCircle")
        CATransaction.commit()
    }
    
}
