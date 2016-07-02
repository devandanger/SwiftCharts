//
//  ChartPointsTrackerLayer.swift
//  SwiftCharts
//
//  Created by ischuetz on 29/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartPointsTrackerLayer<T: ChartPoint>: ChartPointsLayer<T> {
   
    private var view: TrackerView?
    private let locChangedFunc: ((CGPoint) -> ())

    private let lineColor: UIColor
    private let lineWidth: CGFloat
    
    private lazy var currentPositionLineOverlay: UIView = {
        let currentPositionLineOverlay = UIView()
        currentPositionLineOverlay.backgroundColor = self.lineColor
        return currentPositionLineOverlay
    }()
    
    
    public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPoints: [T], locChangedFunc: (CGPoint) -> (), lineColor: UIColor = UIColor.black(), lineWidth: CGFloat = 1) {
        self.locChangedFunc = locChangedFunc
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints)
    }
    
    override func display(chart: Chart) {
        let view = TrackerView(frame: chart.bounds, updateFunc: {[weak self] location in
            self?.locChangedFunc(location)
            self?.currentPositionLineOverlay.center.x = location.x
        })
        view.isUserInteractionEnabled = true
        chart.addSubview(view)
        self.view = view
        
        view.addSubview(self.currentPositionLineOverlay)
        self.currentPositionLineOverlay.frame = CGRect(x: self.innerFrame.origin.x + 200 - self.lineWidth / 2, y: self.innerFrame.origin.y, width: self.lineWidth, height: self.innerFrame.height)
    }
}


private class TrackerView: UIView {
    
    let updateFunc: ((CGPoint) -> ())?
    
    init(frame: CGRect, updateFunc: (CGPoint) -> ()) {
        self.updateFunc = updateFunc
        
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        self.updateFunc?(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        self.updateFunc?(location)
    }
}
