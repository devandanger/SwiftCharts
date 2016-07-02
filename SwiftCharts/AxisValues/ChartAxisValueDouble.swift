//
//  ChartAxisValueDouble.swift
//  SwiftCharts
//
//  Created by ischuetz on 30/08/15.
//  Copyright © 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartAxisValueDouble: ChartAxisValue {
    
    public let formatter: NumberFormatter

    public convenience init(_ int: Int, formatter: NumberFormatter = ChartAxisValueDouble.defaultFormatter, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.init(Double(int), formatter: formatter, labelSettings: labelSettings)
    }
    
    public init(_ double: Double, formatter: NumberFormatter = ChartAxisValueDouble.defaultFormatter, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.formatter = formatter
        super.init(scalar: double, labelSettings: labelSettings)
    }
    
    override public func copy(_ scalar: Double) -> ChartAxisValueDouble {
        return ChartAxisValueDouble(scalar, formatter: self.formatter, labelSettings: self.labelSettings)
    }
    
    static var defaultFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    // MARK: CustomStringConvertible

    override public var description: String {
        return self.formatter.string(from: self.scalar)!
    }
}
