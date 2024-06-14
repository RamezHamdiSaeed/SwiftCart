//
//  AdressTableViewCell.swift
//  SwiftCart
//
//  Created by rwan elmtary on 10/06/2024.
//

import UIKit

class AdressTableViewCell: UITableViewCell {

//    @IBOutlet weak var phoneText: UILabel!
//    @IBOutlet weak var zipCodeText: UILabel!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var countryText: UILabel!
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var addressText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    
}
