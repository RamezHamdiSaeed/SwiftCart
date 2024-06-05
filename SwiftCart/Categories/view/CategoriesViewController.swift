//
//  CategoriesViewController.swift
//  SwiftCart
//
//  Created by marwa on 30/05/2024.
//

import UIKit
import JJFloatingActionButton

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var categoryProductsArray: [Product] = []
    var viewModel : CategoriesViewModel!
    let actionButton = JJFloatingActionButton()
    
    @IBOutlet weak var categorySigmentedButton: UISegmentedControl!
    @IBOutlet weak var singleCategoryProducts: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayFloatingButton()
        CollectionViewDesign.collectionView(colView: singleCategoryProducts)
        viewModel = CategoriesViewModelImp()
        singleCategoryProducts.dataSource = self
        singleCategoryProducts.delegate = self
        //Get Data
        viewModel.productsClosure = {[weak self]
            res in
            DispatchQueue.main.async {
                self?.categoryProductsArray = res
                self?.singleCategoryProducts.reloadData()
            }
        }
        viewModel.getProducts(collectionId: getCategoryName())
        singleCategoryProducts.reloadData()
 
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel = CategoriesViewModelImp()
        //Get Data
        viewModel.productsClosure = {[weak self]
            res in
            DispatchQueue.main.async {
                self?.categoryProductsArray = res
                self?.singleCategoryProducts.reloadData()
            }
        }
        viewModel.getProducts(collectionId: getCategoryName())
        singleCategoryProducts.reloadData()


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryProductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        
        //cell data
        let product = categoryProductsArray[indexPath.item]
        cell.productName.text = product.title
        if let imageUrl = URL(string: product.image.src) {
            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "catimg"))
        } else {
            cell.productImage.image = UIImage(named: "catimg")
        }
        cell.productPrice.text = " \(product.variants[0].price ?? "0.0") EGP "
        
        CollectionViewDesign.collectionViewCell(cell: cell)
        
        return cell
    }
    
    func getCategoryName() -> String {
        switch self.categorySigmentedButton.selectedSegmentIndex {
            case 0 : return Categories.Kids.rawValue
            case 1 : return Categories.Men.rawValue
            case 2 : return Categories.Women.rawValue
            case 3 : return Categories.Sale.rawValue
            
        default:
            return "no Value"
        }
    }
    @IBAction func segButtonAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0 : viewModel.getProducts(collectionId: Categories.Kids.rawValue)
                     self.singleCategoryProducts.reloadData()
            case 1 : viewModel.getProducts(collectionId: Categories.Men.rawValue)
                     self.singleCategoryProducts.reloadData()
            case 2 : viewModel.getProducts(collectionId: Categories.Women.rawValue)
                     self.singleCategoryProducts.reloadData()
            case 3 : viewModel.getProducts(collectionId: Categories.Sale.rawValue)
                     self.singleCategoryProducts.reloadData()
           default:
             print("no Value")
        }
    }
    
    
       func displayFloatingButton(){
           let actionButton = JJFloatingActionButton()
           actionButton.buttonColor = UIColor.systemPink
           
           actionButton.buttonImage = UIImage(named: "menu")

           actionButton.addItem(title: "Shoes", image: UIImage(named: "shoes")?.withRenderingMode(.alwaysTemplate)) { [self] item in

             
               categoryProductsArray = categoryProductsArray.filter{
                    $0.productType == "SHOES"
                }
                singleCategoryProducts.reloadData()


           }

           actionButton.addItem(title: "T-Shirts", image: UIImage(named: "tshirt")?.withRenderingMode(.alwaysTemplate)) {
               [self] item in
                  categoryProductsArray = categoryProductsArray.filter{
                       $0.productType == "T-SHIRTS"
                   }
                   singleCategoryProducts.reloadData()
           }

           actionButton.addItem(title: "Accessories", image: UIImage(named: "jewelry")?.withRenderingMode(.alwaysTemplate)) {
               [self] item in
                  categoryProductsArray = categoryProductsArray.filter{
                       $0.productType == "ACCESSORIES"
                   }
                   singleCategoryProducts.reloadData()
               
           }
           actionButton.display(inViewController: self)
       }
    
}
extension CategoriesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 254)
    }
}
