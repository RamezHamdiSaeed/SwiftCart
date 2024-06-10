//
//  OrdersTableViewCell.swift
//  SwiftCart
//
//  Created by marwa on 07/06/2024.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderPhoneLabel: UILabel!
    @IBOutlet weak var orderSippedLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
