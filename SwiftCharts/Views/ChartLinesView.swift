//
//  ChartLinesView.swift
//  swift_charts
//
//  Created by ischuetz on 11/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public protocol ChartLinesViewPathGenerator {
    func generatePath(points: [CGPoint], lineWidth: CGFloat) -> UIBezierPath
}

public class ChartLinesView: UIView {

    private let lineColor: UIColor
    private let lineWidth: CGFloat
    private let animDuration: Float
    private let animDelay: Float

    init(path: UIBezierPath, frame: CGRect, lineColor: UIColor, lineWidth: CGFloat, animDuration: Float, animDelay: Float) {
        
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.animDuration = animDuration
        self.animDelay = animDelay
        
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear()
        self.show(path: path)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLineMask(frame: CGRect) -> CALayer {
        let lineMaskLayer = CAShapeLayer()
        var maskRect = frame
        maskRect.origin.y = 0
        maskRect.size.height = frame.size.height
        let path = CGPath(rect: maskRect, transform: nil)
        
        lineMaskLayer.path = path
        
        return lineMaskLayer
    }

    private func generateLayer(path: UIBezierPath) -> CAShapeLayer {
        let lineLayer = CAShapeLayer()
        lineLayer.lineJoin = kCALineJoinBevel
        lineLayer.fillColor   = UIColor.clear().cgColor
        lineLayer.lineWidth   = self.lineWidth
        
        lineLayer.path = path.cgPath;
        lineLayer.strokeColor = self.lineColor.cgColor;
        
        if self.animDuration > 0 {
            lineLayer.strokeEnd   = 0.0
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = CFTimeInterval(self.animDuration)
            pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pathAnimation.fromValue = NSNumber(value: 0)
            pathAnimation.toValue = NSNumber(value: 1)
            pathAnimation.autoreverses = false
            pathAnimation.isRemovedOnCompletion = false
            pathAnimation.fillMode = kCAFillModeForwards
            
            pathAnimation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.animDelay)
            lineLayer.add(pathAnimation, forKey: "strokeEndAnimation")
            
        } else {
            lineLayer.strokeEnd = 1
        }
        
        return lineLayer
    }
    
    private func show(path: UIBezierPath) {
        let lineMask = self.createLineMask(frame: frame)
        self.layer.mask = lineMask
        self.layer.addSublayer(self.generateLayer(path: path))
    }
 }
