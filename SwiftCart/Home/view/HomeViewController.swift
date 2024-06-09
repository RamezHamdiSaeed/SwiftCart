
//
//  HomeViewController.swift
//  SwiftCart
//
//  Created by marwa on 23/05/2024.
//

import UIKit
import SDWebImage
import JJFloatingActionButton

class HomeViewController: UIViewController {
    
    var homeViewModel = HomeViewModel()
    var brandsArray: [SmartCollection] = []
    let actionButton = JJFloatingActionButton()

    @IBOutlet weak var AdsCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    let imageNames = ["catimg", "catimg", "catimg", "catimg", "catimg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup collection view
        CollectionViewDesign.collectionView(colView: brandsCollectionView)
        CollectionViewDesign.collectionView(colView: AdsCollectionView)
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        AdsCollectionView.dataSource = self
        AdsCollectionView.delegate = self
        brandsCollectionView.reloadData()
        AdsCollectionView.reloadData()
        
        // Get data of brands
        homeViewModel.brandsClosure = { [weak self] res in
            DispatchQueue.main.async { [weak self] in
                self?.brandsArray = res
                print("", self?.brandsArray[0].title)
                self?.brandsCollectionView.reloadData()
            }
        }
        homeViewModel.getBrands()
        
        setupNavigationBarIcons()
        

        
        actionButton.addItem(title: "New Item", image: UIImage(named: "plusIcon"), action: { item in
            
        })
    }
    func setupNavigationBarIcons() {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.spacing = 10
         stackView.alignment = .center
         stackView.distribution = .equalSpacing
         
         let button1 = UIButton(type: .system)
        button1.setImage(UIImage(named: "searchIcons"), for: .normal)
         button1.tintColor = .systemPink
         button1.addTarget(self, action: #selector(icon1Tapped), for: .touchUpInside)
        button1.widthAnchor.constraint(equalToConstant: 30).isActive = true
       
         let button2 = UIButton(type: .system)
         button2.setImage(UIImage(named: "like"), for: .normal)
         button2.tintColor = .systemPink
         button2.addTarget(self, action: #selector(icon2Tapped), for: .touchUpInside)
        button2.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
         let button3 = UIButton(type: .system)
         button3.setImage(UIImage(named: "shoppingCart"), for: .normal)
        button3.tintColor = .systemPink
         button3.addTarget(self, action: #selector(icon3Tapped), for: .touchUpInside)
        button3.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
         stackView.addArrangedSubview(button1)
         stackView.addArrangedSubview(button2)
         stackView.addArrangedSubview(button3)
         
         let barButtonItem = UIBarButtonItem(customView: stackView)

        tabBarController?.navigationItem.rightBarButtonItem = barButtonItem
     }
    
    @objc func icon1Tapped() {
        // Handle icon1 tap
                        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
                        let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "SearchViewController"))
                        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    
    @objc func icon2Tapped() {
        // Handle icon2 tap
                        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
                        let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "FavoriteViewController"))
                        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    
    @objc func icon3Tapped() {
        // Handle icon3 tap
        print("Icon 3 tapped")
    }
    
    @objc func buttonTapped() {
      print("Floating action button tapped!")
    }
    

  
    
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == AdsCollectionView {
            return imageNames.count
        } else {
            return brandsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == AdsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddsCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            // Cell data
            cell.adsLabel.text = "Marwa"
            cell.adsImage.image = UIImage(named: imageNames[indexPath.item])
             
            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            // Cell data
            cell.cellLabel.text = brandsArray[indexPath.item].title
            cell.cellImage.sd_setImage(with: URL(string: brandsArray[indexPath.item].image.src ?? ""), placeholderImage: UIImage(named: "catimg"))
             
            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("navigationController")
        
        let brandDetails = storyboard?.instantiateViewController(withIdentifier: "BrandDetailViewController") as? BrandDetailViewController
        brandDetails?.collectionIdStr = brandsArray[indexPath.item].id
        navigationController?.pushViewController(brandDetails!, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == AdsCollectionView {
            return CGSize(width: 356, height: 201)
        } else {
            return CGSize(width: 150, height: 160)
        }
    }
}

