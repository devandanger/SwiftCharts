//
//  ChartCandleStickView.swift
//  SwiftCharts
//
//  Created by ischuetz on 29/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartCandleStickView: UIView {

    private let innerRect: CGRect
    
    private let fillColor: UIColor
    private let strokeColor: UIColor
    
    private var currentFillColor: UIColor
    private var currentStrokeColor: UIColor
    
    private let highlightColor = UIColor.red()
   
    private let strokeWidth: CGFloat
    
    var highlighted: Bool = false {
        didSet {
            if self.highlighted {
                self.currentFillColor = self.highlightColor
                self.currentStrokeColor = self.highlightColor
            } else {
                self.currentFillColor = self.fillColor
                self.currentStrokeColor = self.strokeColor
            }
            self.setNeedsDisplay()
        }
    }
    
    public init(lineX: CGFloat, width: CGFloat, top: CGFloat, bottom: CGFloat, innerRectTop: CGFloat, innerRectBottom: CGFloat, fillColor: UIColor, strokeColor: UIColor = UIColor.black(), strokeWidth: CGFloat = 1) {
        
        let frameX = lineX - width / CGFloat(2)
        let frame = CGRect(x: frameX, y: top, width: width, height: bottom - top)
        let t = innerRectTop - top
        let hsw = strokeWidth / 2
        self.innerRect = CGRect(x: hsw, y: t + hsw, width: width - strokeWidth, height: innerRectBottom - top - t - strokeWidth)

        self.fillColor = fillColor
        self.strokeColor = strokeColor
        
        self.currentFillColor = fillColor
        self.currentStrokeColor = strokeColor
        self.strokeWidth = strokeWidth
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        let wHalf = self.frame.width / 2
        
        context?.setLineWidth(self.strokeWidth)
        context?.setStrokeColor(self.currentStrokeColor.cgColor)
        context?.moveTo(x: wHalf, y: 0)
        context?.addLineTo(x: wHalf, y: self.frame.height)
        
        context?.strokePath()
        
        context?.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        context?.setFillColor(self.currentFillColor.cgColor)
        context?.fill(self.innerRect)
        context?.stroke(self.innerRect)
    }
   

}
