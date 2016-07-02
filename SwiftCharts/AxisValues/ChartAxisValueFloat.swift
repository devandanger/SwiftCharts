//
//  ChartAxisValueFloat.swift
//  swift_charts
//
//  Created by ischuetz on 15/03/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

@available(*, deprecated:0.2.5, message:"use ChartAxisValueDouble instead")
public class ChartAxisValueFloat: ChartAxisValue {
    
    public let formatter: NumberFormatter

    public var float: CGFloat {
        return CGFloat(self.scalar)
    }

    public init(_ float: CGFloat, formatter: NumberFormatter = ChartAxisValueFloat.defaultFormatter, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.formatter = formatter
        super.init(scalar: Double(float), labelSettings: labelSettings)
    }
   
    override public func copy(_ scalar: Double) -> ChartAxisValueFloat {
        return ChartAxisValueFloat(CGFloat(scalar), formatter: self.formatter, labelSettings: self.labelSettings)
    }
    
    static var defaultFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    // MARK: CustomStringConvertible

    override public var description: String {
        return self.formatter.string(from: self.float)!
    }
}
