//
//  ReviewsTableViewCell.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 13/06/2024.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var message: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
