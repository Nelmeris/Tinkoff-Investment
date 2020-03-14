//
//  TicketListInteractor.swift
//  Network
//
//  Created by Artem Kufaev on 14.03.2020.
//

import Storage
import Network

protocol ITicketListInteractor: class {
    func loadTickets()
}

protocol ITicketListViewController: class {
    func showError(_ error: Error)
    func showTickets(_ viewModels: [TicketViewModel])
}

class TicketListInteractor {
    
    public var controller: ITicketListViewController!
    
    public var provider: Provider<FinnhubAPI>!
    public var storage: Storage<Ticket>!
    public var viewModelFactory: TicketViewModelFactory!
    
    private(set) var viewModels: [TicketViewModel] = [] {
        didSet { controller.showTickets(viewModels) }
    }
    
}

extension TicketListInteractor: ITicketListInteractor {
    
    public func loadTickets() {
        loadTicketsFromDB()
        loadTicketsFromNetwork()
    }
    
    private func loadTicketsFromDB() {
        storage.readAll { [weak self] (tickets) in
            guard let `self` = self else { return }
            self.viewModels = self.viewModelFactory.make(from: tickets)
        }
    }
    
    private func loadTicketsFromNetwork() {
        provider.load(.stockSymbol(exchange: "US")) { [weak self] (result: NetworkResult<[Ticket]>) in
            guard let `self` = self else { return }
            switch result {
            case .success(let tickets):
                self.storage.write(tickets)
                self.viewModels = self.viewModelFactory.make(from: tickets)
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
}
