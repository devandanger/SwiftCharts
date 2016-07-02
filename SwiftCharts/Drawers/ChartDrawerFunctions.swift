//
//  ChartDrawerFunctions.swift
//  Examples
//
//  Created by ischuetz on 21/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

func ChartDrawLine(context: CGContext, p1: CGPoint, p2: CGPoint, width: CGFloat, color: UIColor) {
    context.setStrokeColor(color.cgColor)
    context.setLineWidth(width)
    context.moveTo(x: p1.x, y: p1.y)
    context.addLineTo(x: p2.x, y: p2.y)
    context.strokePath()
}

func ChartDrawDottedLine(context: CGContext, p1: CGPoint, p2: CGPoint, width: CGFloat, color: UIColor, dotWidth: CGFloat, dotSpacing: CGFloat) {
    context.setStrokeColor(color.cgColor)
    context.setLineWidth(width)
    context.setLineDash(phase: 0, lengths: [dotWidth, dotSpacing], count: 2)
    context.moveTo(x: p1.x, y: p1.y)
    context.addLineTo(x: p2.x, y: p2.y)
    context.strokePath()
    context.setLineDash(phase: 0, lengths: nil, count: 0)
}
