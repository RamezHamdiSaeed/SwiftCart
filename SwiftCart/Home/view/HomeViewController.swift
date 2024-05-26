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
    
    @IBOutlet weak var adsLabel: UILabel!
    @IBOutlet weak var adsScrollView: UIScrollView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    
    
    let imageNames = ["catimg", "catimg", "catimg", "catimg", "catimg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //design Collection
        self.brandsCollectionView.layer.borderWidth = 1.0
        self.brandsCollectionView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        self.brandsCollectionView.layer.cornerRadius = 25
        
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        brandsCollectionView.reloadData()
  
        // Set up the scroll view
        adsLabel.text = "Lovely Marwa"
        adsScrollView.contentSize = CGSize(width: CGFloat(imageNames.count) * adsScrollView.frame.width, height: 200)
        adsScrollView.isPagingEnabled = true
        adsScrollView.showsHorizontalScrollIndicator = false
        
        // Add the images to the scroll view
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = CGRect(x: CGFloat(index) * 300, y: 0
                                     , width: 300, height: 200)
            adsScrollView.addSubview(imageView)
            
            
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

}


extension HomeViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        
        //cell data
        cell.cellLabel.text = brandsArray[indexPath.item].title
        cell.cellImage.sd_setImage(with: URL(string: brandsArray[indexPath.item].image.src ?? ""), placeholderImage: UIImage(named: "catimg"))
        
        // cell design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
              
        return cell
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
        return CGSize(width: 150, height: 160)
    }
}
