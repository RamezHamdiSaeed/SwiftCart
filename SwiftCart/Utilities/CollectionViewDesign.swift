//
//  CollectionViewDesign.swift
//  SwiftCart
//
//  Created by marwa on 30/05/2024.
//

import Foundation
import UIKit

class CollectionViewDesign{
    
    static func collectionView (colView:UICollectionView){
        
        colView.layer.borderWidth = 1.0
        colView.layer.borderColor = UIColor.systemOrange.cgColor
        colView.layer.cornerRadius = 25

    }
    static func collectionViewCell (cell: UICollectionViewCell){
        
        // Cell Design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.systemOrange.cgColor

        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        cell.contentView.backgroundColor = UIColor.white

        
    }
 

  
}

func setBackground(view : UIView){
    // Add background image
//     let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//     backgroundImage.image = UIImage(named: "bacground")
//     backgroundImage.contentMode = .scaleAspectFill
//     view.insertSubview(backgroundImage, at: 0)
    
}

func extractName(from email: String) -> String? {
    let pattern = "^[a-zA-Z]+"
    if let range = email.range(of: pattern, options: .regularExpression) {
        return String(email[range])
    }
    return nil
}
 func styleTableView( tableView: UITableView) {
    tableView.layer.borderWidth = 1.0
    tableView.layer.borderColor = UIColor.systemOrange.cgColor
    tableView.layer.cornerRadius = 25
    
    let backgroundImageView = UIImageView(image: UIImage(named: "background"))
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.frame = tableView.bounds
    backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.backgroundView = backgroundImageView
}

 func styleTableViewCell( cell: UITableViewCell) {
     
    cell.contentView.layer.borderWidth = 1.0
    cell.contentView.layer.borderColor = UIColor.systemOrange.cgColor
    cell.contentView.layer.cornerRadius = 25
    cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    cell.contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
   
}
func setHeader(view: UIViewController, title: String) {
    let settingsLabel = UILabel()
    settingsLabel.text = title
    settingsLabel.textColor = .systemOrange
    
    if let customFont = UIFont(name: "HoeflerText-Italic", size: 30) {
        settingsLabel.font = customFont
    } else {
        settingsLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    settingsLabel.layer.shadowColor = UIColor.black.cgColor
    settingsLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
    settingsLabel.layer.shadowOpacity = 0.3
    settingsLabel.layer.shadowRadius = 2
    
    settingsLabel.sizeToFit()
    view.navigationItem.titleView = settingsLabel
}
