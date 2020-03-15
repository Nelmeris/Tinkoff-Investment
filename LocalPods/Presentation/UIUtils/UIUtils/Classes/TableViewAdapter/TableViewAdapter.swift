//
//  TableViewAdapter.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 04.03.2020.
//

public class TableViewAdapter<Cell: UITableViewCell & ConfigurableCell>:
    NSObject,
    UITableViewDelegate,
    UITableViewDataSource {
    public typealias Model = Cell.ViewModel
    
    private(set) weak var tableView: UITableView!
    private(set) var viewModels: [Model] = [] {
        didSet { tableView.reloadData() }
    }
    
    public init(table: UITableView) {
        self.tableView = table
        super.init()
        table.dataSource = self
        table.delegate = self
        table.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    public func set(items: [Model]) {
        self.viewModels = items
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = self.tableView.dequeueReusableCell(for: indexPath)
        let viewModel = self.viewModels[indexPath.row]
        cell.configure(viewModel, at: indexPath)
        return cell
    }
    
}
