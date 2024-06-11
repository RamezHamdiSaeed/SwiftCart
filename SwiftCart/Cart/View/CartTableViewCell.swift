//
//  CartTableViewCell.swift
//  SwiftCart
//
//  Created by rwan elmtary on 04/06/2024.
//

import UIKit



class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var stepprButton: UIStepper!
    
    
    

    weak var delegate: CartTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        itemImg.layer.cornerRadius = itemImg.frame.size.width / 2
        itemImg.clipsToBounds = true

        stepprButton.minimumValue = 1
        stepprButton.value = 1
        stepprButton.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)

        quantity.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        stepprButton.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }

    @objc private func stepperValueChanged(_ sender: UIStepper) {
        let newQuantity = Int(sender.value)
        quantity.text = "\(newQuantity)"
        delegate?.didChangeQuantity(cell: self, quantity: newQuantity)
    }
}
