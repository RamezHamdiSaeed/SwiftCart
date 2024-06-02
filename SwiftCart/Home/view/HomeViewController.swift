//  HomeViewController.swift
//  SwiftCart
//
//  Created by marwa on 23/05/2024.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController {
    
    var homeViewModel = HomeViewModel()
    var brandsArray   : [SmartCollection] = []
    
    @IBOutlet weak var AdsCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    
    
    let imageNames = ["catimg", "catimg", "catimg", "catimg", "catimg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        CollectionViewDesign.collectionView(colView: brandsCollectionView)
        
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        AdsCollectionView.dataSource = self
        AdsCollectionView.delegate = self
        brandsCollectionView.reloadData()
        AdsCollectionView.reloadData()
        
        //get Data of Brands
            homeViewModel.brandsClosure = { [weak self]
                res in
                DispatchQueue.main.async { [weak self] in
                    self?.brandsArray = res
                    print("",self?.brandsArray[0].title)
                    self?.brandsCollectionView.reloadData()
                }
                
            }
            homeViewModel.getBrands()
        }
        
    }




extension HomeViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == AdsCollectionView{
            return imageNames.count
        }
        else
        {
            return brandsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == AdsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddsCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            //cell data
            cell.adsLabel.text = "Marwa"
            cell.adsImage.image = UIImage(named: imageNames[indexPath.item])
             
            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
            
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            //cell data
            cell.cellLabel.text = brandsArray[indexPath.item].title
            cell.cellImage.sd_setImage(with: URL(string: brandsArray[indexPath.item].image.src ?? ""), placeholderImage: UIImage(named: "catimg"))
             
            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
            
            
        }
    }
}



extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("navigationController")
        
        let brandDetails = storyboard?.instantiateViewController(withIdentifier: "BrandDetailViewController") as? BrandDetailViewController
        brandDetails?.collectionIdStr = brandsArray[indexPath.item].id
        navigationController?.pushViewController( brandDetails! , animated: true )

    }
}



extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == AdsCollectionView{
            return CGSize(width: 356, height: 201)
        }
        else
        {
            return CGSize(width: 150, height: 160)
        }

    }
    
    
}
