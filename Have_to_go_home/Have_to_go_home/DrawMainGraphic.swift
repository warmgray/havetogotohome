//
//  DrawMainGraphic.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class DrawMainGraphic: UIView {

    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(CGFloat(2.0))
        context?.setStrokeColor(UIColor(red: 62/255 , green: 163/255, blue: 253/255, alpha: 1.0).cgColor)
        
        let basicCircle = CGRect.init(x: 1.0, y: 1.0, width: 1.0, height: 1.0)
        context?.addEllipse(in: basicCircle)
        context?.strokePath()
    }

}
