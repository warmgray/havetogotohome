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
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    } // init
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clear
        
    } // init

    private func getGraphStartAndEndPointsInRadians() -> (graphStartingPoint: CGFloat, graphEndingPoint: CGFloat) {
        
        // make sure our starting point is at least 0 and less than 100
        if ( 0 > self.startPoint ) {
            self.startPoint = 0
        } else if ( 100 < self.startPoint ) {
            self.startPoint = 100
        } // if
        
        // make sure our fill percentage is at least 0 and less than 100
        if ( 0 > self.fillPercentage ) {
            self.fillPercentage = 0
        } else if ( 100 < self.fillPercentage ) {
            self.fillPercentage = 100
        } // if
        
        // we take 25% off the starting point, so that a zero starting point
        // begins at the top of the circle instead of the right side...
        self.startPoint = self.startPoint - 25
        
        // we calculate a true fill percentage as we need to account
        // for the potential difference in starting points
        let trueFillPercentage = self.fillPercentage + self.startPoint
        
        let π: CGFloat = CGFloat(M_PI)
        
        // now we can calculate our start and end points in radians
        let startPoint: CGFloat = ((2 * π) / 100) * (CGFloat(self.startPoint))
        let endPoint: CGFloat = ((2 * π) / 100) * (CGFloat(trueFillPercentage))
        
        return(startPoint, endPoint)
        
    } // func
    
    override func draw(_ rect: CGRect) {
        
        // first we want to find the centerpoint and the radius of our rect
        let center: CGPoint = CGPoint(x: 160, y: 221)
        let radius: CGFloat = 106
        
        
        // make sure our track width is at least 1
        if ( 1 > self.trackWidth) {
            self.trackWidth = 1
        } // if
        
        // and our track width cannot be greater than the radius of our circle
        if ( radius < self.trackWidth ) {
            self.trackWidth = radius
        } // if
        
        // we need our graph starting and ending points
        let (graphStartingPoint, graphEndingPoint) = self.getGraphStartAndEndPointsInRadians()
        
        // now we need to first draw the track...
        let trackPath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: graphStartingPoint, endAngle: 2.0 * CGFloat(M_PI), clockwise: true)
        trackPath.lineWidth = trackWidth
        self.trackColor.setStroke()
        trackPath.stroke()
        
        // now we can draw the progress arc
        let percentagePath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: graphStartingPoint, endAngle: graphEndingPoint, clockwise: true)
        percentagePath.lineWidth = trackWidth
        
        self.color.setStroke()
        percentagePath.stroke()
        
        return
        
    } // func

       
}
