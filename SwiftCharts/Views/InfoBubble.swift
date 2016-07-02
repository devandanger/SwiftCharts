//
//  InfoBubble.swift
//  SwiftCharts
//
//  Created by ischuetz on 11/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

// Quick implementation of info bubble, for demonstration purposes
// For serious usage you may consider using a library specialized in this e.g. CMPopTipView
public class InfoBubble: UIView {

    private let arrowWidth: CGFloat
    private let arrowHeight: CGFloat
    private let bgColor: UIColor
    private let arrowX: CGFloat
    
    public init(frame: CGRect, arrowWidth: CGFloat, arrowHeight: CGFloat, bgColor: UIColor = UIColor.white(), arrowX: CGFloat) {
        self.arrowWidth = arrowWidth
        self.arrowHeight = arrowHeight
        self.bgColor = bgColor

        let arrowHalf = arrowWidth / 2
        self.arrowX = max(arrowHalf, min(frame.size.width - arrowHalf, arrowX))
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.bgColor.cgColor)
        context?.setStrokeColor(self.bgColor.cgColor)
        let rrect = rect.insetBy(dx: 0, dy: 20)
        
        let minx = rrect.minX, maxx = rrect.maxX
        let miny = rrect.minY, maxy = rrect.maxY
        
        let outlinePath = CGMutablePath()
        
        outlinePath.moveTo(nil, x: minx, y: miny)
        outlinePath.addLineTo(nil, x: maxx, y: miny)
        outlinePath.addLineTo(nil, x: maxx, y: maxy)
        outlinePath.addLineTo(nil, x: self.arrowX + self.arrowWidth / 2, y: maxy)
        outlinePath.addLineTo(nil, x: self.arrowX, y: maxy + self.arrowHeight)
        outlinePath.addLineTo(nil, x: self.arrowX - self.arrowWidth / 2, y: maxy)

        outlinePath.addLineTo(nil, x: minx, y: maxy)
        
        outlinePath.closeSubpath()

        context?.addPath(outlinePath)
        context?.fillPath()
    }
}
