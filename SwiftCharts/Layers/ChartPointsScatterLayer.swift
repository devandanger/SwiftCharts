//
//  ChartPointsScatterLayer.swift
//  Examples
//
//  Created by ischuetz on 17/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartPointsScatterLayer<T: ChartPoint>: ChartPointsLayer<T> {

    public let itemSize: CGSize
    public let itemFillColor: UIColor
    
    required public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPoints: [T], displayDelay: Float = 0, itemSize: CGSize, itemFillColor: UIColor) {
        self.itemSize = itemSize
        self.itemFillColor = itemFillColor
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, displayDelay: displayDelay)
    }
    
    override public func chartViewDrawing(context: CGContext, chart: Chart) {
        for chartPointModel in self.chartPointsModels {
            self.drawChartPointModel(context: context, chartPointModel: chartPointModel)
        }
    }
    
    public func drawChartPointModel(context: CGContext, chartPointModel: ChartPointLayerModel<T>) {
        fatalError("override")
    }
}

public class ChartPointsScatterTrianglesLayer<T: ChartPoint>: ChartPointsScatterLayer<T> {
    
    required public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPoints: [T], displayDelay: Float = 0, itemSize: CGSize, itemFillColor: UIColor) {
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, displayDelay: displayDelay, itemSize: itemSize, itemFillColor: itemFillColor)
    }
    
    override public func drawChartPointModel(context: CGContext, chartPointModel: ChartPointLayerModel<T>) {
        let w = self.itemSize.width
        let h = self.itemSize.height
        
        let path = CGMutablePath()
        path.moveTo(nil, x: chartPointModel.screenLoc.x, y: chartPointModel.screenLoc.y - h / 2)
        path.addLineTo(nil, x: chartPointModel.screenLoc.x + w / 2, y: chartPointModel.screenLoc.y + h / 2)
        path.addLineTo(nil, x: chartPointModel.screenLoc.x - w / 2, y: chartPointModel.screenLoc.y + h / 2)
        path.closeSubpath()
        
        context.setFillColor(self.itemFillColor.cgColor)
        context.addPath(path)
        context.fillPath()
    }
}

public class ChartPointsScatterSquaresLayer<T: ChartPoint>: ChartPointsScatterLayer<T> {
    
    required public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPoints: [T], displayDelay: Float = 0, itemSize: CGSize, itemFillColor: UIColor) {
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, displayDelay: displayDelay, itemSize: itemSize, itemFillColor: itemFillColor)
    }
    
    override public func drawChartPointModel(context: CGContext, chartPointModel: ChartPointLayerModel<T>) {
        let w = self.itemSize.width
        let h = self.itemSize.height
        
        context.setFillColor(self.itemFillColor.cgColor)
        context.fill(CGRect(x: chartPointModel.screenLoc.x - w / 2, y: chartPointModel.screenLoc.y - h / 2, width: w, height: h))
    }
}

public class ChartPointsScatterCirclesLayer<T: ChartPoint>: ChartPointsScatterLayer<T> {
    
    required public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPoints: [T], displayDelay: Float = 0, itemSize: CGSize, itemFillColor: UIColor) {
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, displayDelay: displayDelay, itemSize: itemSize, itemFillColor: itemFillColor)
    }
    
    override public func drawChartPointModel(context: CGContext, chartPointModel: ChartPointLayerModel<T>) {
        let w = self.itemSize.width
        let h = self.itemSize.height
        
        context.setFillColor(self.itemFillColor.cgColor)
        context.fillEllipse(in: CGRect(x: chartPointModel.screenLoc.x - w / 2, y: chartPointModel.screenLoc.y - h / 2, width: w, height: h))
    }
}

public class ChartPointsScatterCrossesLayer<T: ChartPoint>: ChartPointsScatterLayer<T> {
    
    public let strokeWidth: CGFloat
    
    required public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPoints: [T], displayDelay: Float = 0, itemSize: CGSize, itemFillColor: UIColor, strokeWidth: CGFloat = 2) {
        self.strokeWidth = strokeWidth
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, displayDelay: displayDelay, itemSize: itemSize, itemFillColor: itemFillColor)
    }
    
    override public func drawChartPointModel(context: CGContext, chartPointModel: ChartPointLayerModel<T>) {
        let w = self.itemSize.width
        let h = self.itemSize.height
        
        func drawLine(_ p1X: CGFloat, p1Y: CGFloat, p2X: CGFloat, p2Y: CGFloat) {
            context.setStrokeColor(self.itemFillColor.cgColor)
            context.setLineWidth(self.strokeWidth)
            context.moveTo(x: p1X, y: p1Y)
            context.addLineTo(x: p2X, y: p2Y)
            context.strokePath()
        }

        drawLine(chartPointModel.screenLoc.x - w / 2, p1Y: chartPointModel.screenLoc.y - h / 2, p2X: chartPointModel.screenLoc.x + w / 2, p2Y: chartPointModel.screenLoc.y + h / 2)
        drawLine(chartPointModel.screenLoc.x + w / 2, p1Y: chartPointModel.screenLoc.y - h / 2, p2X: chartPointModel.screenLoc.x - w / 2, p2Y: chartPointModel.screenLoc.y + h / 2)
    }
}
