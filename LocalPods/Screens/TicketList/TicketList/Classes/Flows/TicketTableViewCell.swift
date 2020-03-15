//
//  TicketTableViewCell.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

import UIKit
import UIUtils
import DesignKit

class TicketTableViewCell: UITableViewCell, ConfigurableCell {
    typealias ViewModel = TicketViewModel

    @IBOutlet weak var iconView: GradientView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureIconView()
    }

    private func configureIconView() {
        // Circle
        iconView.cornerRadius = iconView.bounds.height / 2
        // Gradient
        iconView.topColor = .random
        iconView.bottomColor = .random
        iconView.startPointX = 0
        iconView.startPointY = 0
        iconView.endPointX = 1
        iconView.endPointY = 1
        // Border
        iconView.borderColor = .gray
        iconView.borderWidth = 3
    }

    func configure(_ viewModel: TicketViewModel, at indexPath: IndexPath) {
        symbolLabel.text = viewModel.symbol
        descriptionLabel.text = viewModel.description
    }

}
