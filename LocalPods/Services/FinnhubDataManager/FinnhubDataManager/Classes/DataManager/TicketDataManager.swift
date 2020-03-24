//
//  TicketDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network

public class TicketDataManager: FinnhubDataManager<Ticket> {
    
    public func load(exchange: String, completion: @escaping ((Result<[Ticket], NetworkError>) -> Void)) {
        loadFromDB { completion(.success($0))}
        loadFromNetwork(api: .stockSymbol(exchange: exchange)) { completion($0) }
    }
    
}
