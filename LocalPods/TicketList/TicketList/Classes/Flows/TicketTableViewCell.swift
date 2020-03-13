//
//  TicketTableViewCell.swift
//  Network
//
//  Created by Artem Kufaev on 13.03.2020.
//

import UIKit
import UIViewKit

class TicketTableViewCell: UITableViewCell, ConfigurableCell {
    typealias ViewModel = TicketViewModel

    @IBOutlet weak var iconView: TicketTableViewCell!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: TicketViewModel, at indexPath: IndexPath) {
        symbolLabel.text = viewModel.symbol
        descriptionLabel.text = viewModel.description
    }
    
}
