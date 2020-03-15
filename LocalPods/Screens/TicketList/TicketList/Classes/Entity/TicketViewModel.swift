//
//  TicketViewModel.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

import FinnhubDataManager

struct TicketViewModel {
    let symbol: String
    let description: String
}

class TicketViewModelFactory {
    public func make(from models: [Ticket]) -> [TicketViewModel] {
        return models.map(make)
    }

    public func make(from model: Ticket) -> TicketViewModel {
        let symbol = model.symbol
        let description = model.description
        return TicketViewModel(symbol: symbol, description: description)
    }
}
