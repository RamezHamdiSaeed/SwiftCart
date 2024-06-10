//
//  BrandDetailsViewController.swift
//  SwiftCart
//
//  Created by marwa on 26/05/2024.

import UIKit
import SDWebImage

class BrandDetailViewController: UIViewController {

    
    @IBOutlet weak var brandProductsCollectionView: UICollectionView!
    
    var collectionIdStr : Int = 0
    var productViewModel = ProductsViewModel()
    var productsArray: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionViewDesign.collectionView(colView: brandProductsCollectionView)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Configure Cell
        let product = productsArray[indexPath.item]
        cell.productName.text = product.title
        if let imageUrl = URL(string: product.image.src) {
            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "catimg"))
        } else {
            cell.productImage.image = UIImage(named: "catimg")
        }
        cell.productPrice.text = " \(product.variants[0].price ?? "0.0") EGP "
                
        CollectionViewDesign.collectionViewCell(cell: cell)
        cell.product = product

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        // Configure Cell
//        let product = productsArray[indexPath.item]
//        cell.productName.text = product.title
//        if let imageUrl = URL(string: product.image.src) {
//            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "catimg"))
//        } else {
//            cell.productImage.image = UIImage(named: "catimg")
//        }
//        cell.productPrice.text = " \(product.variants[0].price ?? "0.0") EGP "
//
//        CollectionViewDesign.collectionViewCell(cell: cell)
//        cell.product = product
//
//
//        return cell
//    }
}

extension BrandDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle Cell Selection
    }
}

extension BrandDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 254)
    }
}


