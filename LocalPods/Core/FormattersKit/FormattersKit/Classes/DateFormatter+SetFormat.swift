//
//  DateFormatter+SetFormat.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

extension DateFormatter {

    public func setFormat(_ format: DateFormat) {
        self.dateFormat = format.rawValue
    }

}
