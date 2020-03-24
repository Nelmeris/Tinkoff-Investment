//
//  DateFormat.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

public enum DateFormat: String {
    case newsFeedCell = "HH:mm yy/MM/dd"
}

extension DateFormatter {

    convenience init(with format: DateFormat?) {
        self.init()
        guard let format = format else { return }
        self.dateFormat = format.rawValue
    }

}
