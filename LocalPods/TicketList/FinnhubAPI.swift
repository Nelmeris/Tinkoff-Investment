//
//  FinnhubAPI.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

public enum FinnhubAPI {
    case stockSymbol(exchange: String)
    case stockExchange
    
    var apiKey: String { return "bpkpa07rh5rcgrlrc06g" }
}
