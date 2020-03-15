//
//  CellProtocols.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 04.03.2020.
//

public protocol ConfigurableCell: ReusableCell {
    associatedtype ViewModel

    func configure(_ viewModel: ViewModel, at indexPath: IndexPath)
}
