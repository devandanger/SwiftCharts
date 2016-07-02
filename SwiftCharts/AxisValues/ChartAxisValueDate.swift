//
//  ChartAxisValueDate.swift
//  swift_charts
//
//  Created by ischuetz on 01/03/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartAxisValueDate: ChartAxisValue {
  
    private let formatter: (Date) -> String

    public var date: Date {
        return ChartAxisValueDate.dateFromScalar(self.scalar)
    }

    public init(date: Date, formatter: (Date) -> String, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.formatter = formatter
        super.init(scalar: ChartAxisValueDate.scalarFromDate(date), labelSettings: labelSettings)
    }

    convenience public init(date: Date, formatter: DateFormatter, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.init(date: date, formatter: { formatter.string(from: $0) }, labelSettings: labelSettings)
    }
    
    public class func dateFromScalar(_ scalar: Double) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(scalar))
    }
    
    public class func scalarFromDate(_ date: Date) -> Double {
        return Double(date.timeIntervalSince1970)
    }

    // MARK: CustomStringConvertible

    override public var description: String {
        return self.formatter(self.date)
    }
}

