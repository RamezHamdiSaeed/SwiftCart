//
//  CartTableViewCell.swift
//  SwiftCart
//
//  Created by rwan elmtary on 04/06/2024.
//
import UIKit
import SDWebImage

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
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        let newQuantity = Int(sender.value)
        quantity.text = "\(newQuantity)"
        delegate?.didChangeQuantity(cell: self, quantity: newQuantity)
    }
    
    func configure(with lineItem: LineItems, rate: Double, userCurrency: String) {
        var convertedPrice = convertPrice(price: String(lineItem.price  ?? ""), rate: rate)
        itemPrice.text = "\(String(format: "%.2f", convertedPrice)) \(userCurrency)"
        itemName.text = lineItem.title
        quantity.text = "\(lineItem.quantity ?? 0)"
        stepprButton.value = Double(lineItem.quantity ?? 0)
        stepprButton.minimumValue = 1
        
        if let maxQuantity = lineItem.inventoryQuantity {
            stepprButton.maximumValue = Double(maxQuantity)
        } else {
            stepprButton.maximumValue = 3
        }
        
        if let imageUrlString = lineItem.productImage, let imageUrl = URL(string: imageUrlString) {
            itemImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            itemImg.image = UIImage(named: "TrendyIcon")
        }
    }
}
