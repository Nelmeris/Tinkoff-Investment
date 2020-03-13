//
//  TicketList.swift
//  Tinkoff Tech Authentificator
//
//  Created by Artem Kufaev on 13.03.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import UIViewKit
import Network
import Storage
import CoreData

public struct Ticket: Decodable {
    let symbol: String
    let displaySymbol: String
    let description: String
}

extension Ticket: ManagedObjectConvertible {
    public typealias ManagedObject = TicketCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> Ticket.ManagedObject? {
        guard let obj = TicketCD.getOrCreateSingle(with: self, from: context) else { return nil }
        obj.symbol = self.symbol
        obj.displaySymbol = self.displaySymbol
        obj.descript = self.description
        return obj
    }
}

struct TicketViewModel {
    let symbol: String
    
    static func make(from models: [Ticket]) -> [TicketViewModel] {
        return models.map(make)
    }
    
    static func make(from model: Ticket) -> TicketViewModel {
        return TicketViewModel(symbol: model.symbol)
    }
}

public enum TicketAPI {
    case stockSymbol(exchange: String)
    
    var apiKey: String { return "bpkpa07rh5rcgrlrc06g" }
}

extension TicketAPI: INetworkAPI {
    public var schema: NetworkSchema { return .https }
    
    public var host: String { return "finnhub.io/api/v1" }
    
    public var path: String {
        switch self {
        case .stockSymbol: return "/stock/symbol"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .stockSymbol: return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .stockSymbol(let exchange):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["exchange": exchange,
                                                      "token": apiKey])
        }
    }
    
    public var headers: HTTPHeaders? { return nil }
}

class TicketTableCell: UITableViewCell, ConfigurableCell {
    typealias ViewModel = TicketViewModel
    
    func configure(_ viewModel: TicketViewModel, at indexPath: IndexPath) {
        self.textLabel?.text = viewModel.symbol
    }
}

class TicketTableController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tableAdapter: TableViewAdapter<TicketTableCell>!
    var provider: Provider<TicketAPI>!
    var storage: Storage<Ticket>!
    
    var viewModels: [TicketViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableAdapter.set(items: self.viewModels)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableAdapter = TableViewAdapter<TicketTableCell>(table: tableView)
        self.provider = Provider<TicketAPI>()
        self.storage = Storage<Ticket>(modelName: "Model")
        load()
    }
    
    private func load() {
        storage.readAll { [weak self] (tickets) in
            self?.viewModels = TicketViewModel.make(from: tickets)
        }
        self.provider.load(.stockSymbol(exchange: "US")) { [weak self] (result: NetworkResult<[Ticket]>) in
            switch result {
            case .success(let tickets):
                self?.storage.write(tickets)
                self?.viewModels = TicketViewModel.make(from: tickets)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
