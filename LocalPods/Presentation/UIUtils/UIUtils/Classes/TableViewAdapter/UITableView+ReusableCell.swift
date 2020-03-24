//
//  UITableView+ReusableCell.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 04.03.2020.
//

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    func dequeueReusableCell<T: ReusableCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }

}
