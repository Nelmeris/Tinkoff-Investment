//
//  TicketDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

public class TicketDataManager {
    private let baseDataManager: FinnhubDataManager<Ticket>
    
    public init() {
        self.baseDataManager = FinnhubDataManager()
    }
    
    public func load(exchange: String, completion: @escaping ((Result<[Ticket], Error>) -> Void)) {
        baseDataManager.load(api: .stockSymbol(exchange: exchange)) { (result) in
            completion(result)
        }
    }
}
