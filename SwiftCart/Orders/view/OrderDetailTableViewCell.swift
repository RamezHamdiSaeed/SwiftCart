//
//  OrderDetailTableViewCell.swift
//  SwiftCart
//
//  Created by marwa on 08/06/2024.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var orderProductsImage: UIImageView!
    
    @IBOutlet weak var orderProductsPrice: UILabel!
    
    @IBOutlet weak var orderProductsName: UILabel!
    
    
    @IBOutlet weak var orderProductsQuantity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyleToFrame(to: cellFrame)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
