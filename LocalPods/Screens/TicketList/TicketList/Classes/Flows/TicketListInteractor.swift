//
//  TicketListInteractor.swift
//  Network
//
//  Created by Artem Kufaev on 14.03.2020.
//

import FinnhubDataManager
import SwiftUI
import DetailStockScreen

protocol ITicketListInteractor: class {
    func loadTickets()
    func ticketDidSelect(on indexPath: IndexPath)
}

protocol ITicketListViewController: UIViewController {
    func showError(_ error: Error)
    func showTickets(_ viewModels: [TicketViewModel])
}

class TicketListInteractor {

    public var controller: ITicketListViewController!

    public var dataManager: TicketDataManager!
    public var viewModelFactory: TicketViewModelFactory!

    private(set) var viewModels: [TicketViewModel] = [] {
        didSet { controller.showTickets(viewModels) }
    }

}

extension TicketListInteractor: ITicketListInteractor {

    public func loadTickets() {
        dataManager.load(exchange: "US") { (result) in
            switch result {
            case .success(let tickets):
                let viewModels = self.viewModelFactory.make(from: tickets)
                self.viewModels = viewModels
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
    public func ticketDidSelect(on indexPath: IndexPath) {
        let ticket = viewModels[indexPath.row]
        let controller = UIHostingController(rootView: DetailStockView(with: ticket.symbol))
        self.controller.navigationController?.pushViewController(controller, animated: true)
    }

}
