//
//  TicketAPI.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

public enum TicketAPI {
    case stockSymbol(exchange: String)
    
    var apiKey: String { return "bpkpa07rh5rcgrlrc06g" }
}
