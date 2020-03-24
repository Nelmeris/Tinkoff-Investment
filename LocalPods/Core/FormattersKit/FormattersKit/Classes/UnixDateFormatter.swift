//
//  UnixDateFormatter.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Foundation

extension DateFormatter {

    public func string(fromUnixTimestamp time: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: time)
        return self.string(from: date)
    }

    public static func unix(with format: DateFormat? = nil) -> DateFormatter {
        let dateFormatter = DateFormatter(with: format)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current
        return dateFormatter
    }

}
