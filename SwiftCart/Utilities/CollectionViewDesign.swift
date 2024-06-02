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
        colView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        colView.layer.cornerRadius = 25

        
//        let brandsLayout = UICollectionViewFlowLayout()
//                brandsLayout.scrollDirection = .horizontal
//                let itemWidth = (view.frame.width / 2) - 15
//                brandsLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
//                brandsCollection.collectionViewLayout = brandsLayout
    }
    static func collectionViewCell (cell: UICollectionViewCell){
        
        // Cell Design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
    }
    
  
}
