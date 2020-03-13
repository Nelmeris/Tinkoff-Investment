//
//  Ticket.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

public struct Ticket: Decodable {
    let symbol: String
    let displaySymbol: String
    let description: String
}
