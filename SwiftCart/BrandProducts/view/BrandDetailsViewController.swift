//
//  BrandDetailsViewController.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.
//
/*
import Foundation
import UIKit

class BrandDetailViewController: UIViewController {

    var homeViewModel = ProductsViewModel()
    var productsArray : [Product] = []
    
 
    @IBOutlet weak var brandProductsCollectionView: UICollectionView!
    
    let imageNames = ["catimg", "catimg", "catimg", "catimg", "catimg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //design Collection
        self.brandProductsCollectionView.layer.borderWidth = 1.0
        self.brandProductsCollectionView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        self.brandProductsCollectionView.layer.cornerRadius = 25
        
        brandProductsCollectionView.dataSource = self
        brandProductsCollectionView.delegate = self
        brandProductsCollectionView.reloadData()
        
        
        //get Data of Brands Products
        homeViewModel.productsClosure = { [weak self]
                        res in
                        DispatchQueue.main.async { [weak self] in
                            self?.productsArray = res
                            print("",self?.productsArray[0].title ?? "NOONe")
                            self?.brandProductsCollectionView.reloadData()
                        }
                    }
       homeViewModel.getProducts()
    }
        }

extension BrandDetailViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        
        //cell data
        print("cell data",productsArray[indexPath.item].title)
        cell.cellLabel.text = productsArray[indexPath.item].title
        cell.cellImage.sd_setImage(with: URL(string: productsArray[indexPath.item].image.src ?? ""), placeholderImage: UIImage(named: "catimg"))
        
        // cell design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
       
                
        return cell
    }
}



extension BrandDetailViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("")
    }
}



extension BrandDetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 160)
    }
}
*/
import UIKit
import SDWebImage // Import SDWebImage for image loading

class BrandDetailViewController: UIViewController {
    
    var collectionIdStr : Int = 0
    var productViewModel = ProductsViewModel()
    var productsArray: [Product] = []
    
    @IBOutlet weak var brandProductsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Design Collection View
        brandProductsCollectionView.layer.borderWidth = 1.0
        brandProductsCollectionView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        brandProductsCollectionView.layer.cornerRadius = 25
        
        brandProductsCollectionView.dataSource = self
        brandProductsCollectionView.delegate = self
        
        // Get Data of Brand's Products
        productViewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.productsArray = res
                self?.brandProductsCollectionView.reloadData()
                print("DispatchQueue.main.async ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``````````````````````````````````````````````````````````````",self?.productsArray.count )
            }
        }
        
        productViewModel.getProducts(collectionId: collectionIdStr)
        brandProductsCollectionView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        productViewModel.productsClosure = { [weak self] res in
            DispatchQueue.main.async {
                self?.productsArray = res
                self?.brandProductsCollectionView.reloadData()
                print("DispatchQueue.main.async ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``````````````````````````````````````````````````````````````",self?.productsArray.count )
            }
        }
        
        productViewModel.getProducts(collectionId: collectionIdStr)
        brandProductsCollectionView.reloadData()
    }
}


extension BrandDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Configure Cell
        let product = productsArray[indexPath.item]
        cell.cellLabel.text = product.title
        if let imageUrl = URL(string: product.image.src) {
            cell.cellImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "catimg"))
        } else {
            cell.cellImage.image = UIImage(named: "catimg")
        }
        
        // Cell Design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        return cell
    }
}

extension BrandDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle Cell Selection
    }
}

extension BrandDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 160)
    }
}
