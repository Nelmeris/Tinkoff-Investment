//
//  TicketViewModel.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

struct TicketViewModel {
    let symbol: String
    let description: String
}

class TicketViewModelFabric {
    static func make(from models: [Ticket]) -> [TicketViewModel] {
        return models.map(make)
    }
    
    static func make(from model: Ticket) -> TicketViewModel {
        let symbol = model.symbol
        let description = model.description
        return TicketViewModel(symbol: symbol, description: description)
    }
}
