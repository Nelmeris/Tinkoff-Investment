//
//  TicketListController.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

import UIViewKit
import Network
import Storage

public class TicketListViewController: UIViewController {
    
    @IBOutlet weak var ticketTableView: UITableView!
    var tableAdapter: TableViewAdapter<TicketTableViewCell>!
    
    var interactor: ITicketListInteractor!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(for: TicketTableViewCell.self)
        let nib = UINib(nibName: "TicketTableViewCell", bundle: bundle)
        self.tableAdapter = TableViewAdapter(table: ticketTableView, nib: nib)
        self.ticketTableView.estimatedRowHeight = 80
        self.ticketTableView.rowHeight = 80
        interactor.loadTickets()
    }
    
    public class func build() -> TicketListViewController {
        let bundle = Bundle(for: TicketListViewController.self)
        let controller = TicketListViewController(nibName: "TicketListViewController", bundle: bundle)
        let interactor = TicketListInteractor()
        controller.interactor = interactor
        interactor.controller = controller
        interactor.provider = Provider<FinnhubAPI>()
        interactor.storage = Storage<Ticket>(modelName: "Model", bundle: bundle)
        interactor.viewModelFactory = TicketViewModelFactory()
        return controller
    }
    
}

extension TicketListViewController: ITicketListViewController {
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func showTickets(_ viewModels: [TicketViewModel]) {
        tableAdapter.set(items: viewModels)
    }
    
}
