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
        //UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0).cgColor
        colView.layer.cornerRadius = 25
        
        let backgroundImageView = UIImageView(image: UIImage(named: "bacground"))
         backgroundImageView.contentMode = .scaleAspectFill
         backgroundImageView.frame = colView.bounds
         backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         colView.backgroundView = backgroundImageView

        

    }
    static func collectionViewCell (cell: UICollectionViewCell){
        
        // Cell Design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.systemOrange.cgColor

        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        cell.contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.5) // 0.5 for 50% opacity

        
    }

  
}
