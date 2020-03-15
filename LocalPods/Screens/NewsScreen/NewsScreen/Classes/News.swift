//
//  News.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Foundation

struct News: Decodable {
    let id: Int
    let image: URL
    let headline: String
    let summary: String
    let datetime: TimeInterval
    let url: URL
}
