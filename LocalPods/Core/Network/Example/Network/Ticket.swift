//
//  Ticket.swift
//  Network_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

struct Ticket: Decodable {
    let symbol: String
    let displaySymbol: String
    let description: String
}
