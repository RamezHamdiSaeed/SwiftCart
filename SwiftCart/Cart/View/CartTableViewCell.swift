//
//  CartTableViewCell.swift
//  SwiftCart
//
//  Created by rwan elmtary on 04/06/2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var stepprButton: UIStepper!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
