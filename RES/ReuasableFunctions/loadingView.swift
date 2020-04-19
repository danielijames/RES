//
//  loadingView.swift
//  RES
//
//  Created by Daniel James on 4/18/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit

class loadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addLoadingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLoadingView()
    }
    
    
    
    func addLoadingView(){
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = .init(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        
        var circleLayer = CAShapeLayer()
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.width*0.5, y: view.bounds.height*0.5), radius: 50, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        circleLayer.strokeColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        circleLayer.lineWidth = 10.0;
        //wait for animation to draw
        circleLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 10
        animation.speed = 5
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 5
        animation.isRemovedOnCompletion = true
        animation.timeOffset = 5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        circleLayer.strokeEnd = 1
        
        circleLayer.add(animation, forKey: "animateCircle")
        
        view.layer.addSublayer(circleLayer)
        
        super.addSubview(view)
        
        NSLayoutConstraint.activate([view.widthAnchor.constraint(equalToConstant: ScreenSize.width),view.heightAnchor.constraint(equalToConstant: ScreenSize.height)])
    }
}
