//
//  OrdersTableViewCell.swift
//  SwiftCart
//
//  Created by marwa on 07/06/2024.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderCellFrame: UIView!

    @IBOutlet weak var orderSippedLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyStyleToFrame(to: orderCellFrame)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
