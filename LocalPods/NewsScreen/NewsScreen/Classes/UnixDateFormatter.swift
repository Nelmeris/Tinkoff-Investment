//
//  UnixDateFormatter.swift
//  Kingfisher
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Foundation

extension DateFormatter {
    
    static func unix() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        return dateFormatter
    }
    
}
