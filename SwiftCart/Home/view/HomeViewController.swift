
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
    let imageNames = ["60", "50", "10", "15", "25"]
    

    @IBOutlet weak var AdsCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    @IBOutlet var brandWordLabel: UIView!
    var adsScrollTimer: Timer?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkIndicator.startAnimating(view: self.view)
        CollectionViewDesign.collectionView(colView: brandsCollectionView)
        CollectionViewDesign.collectionView(colView: AdsCollectionView)
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        AdsCollectionView.dataSource = self
        AdsCollectionView.delegate = self
        brandsCollectionView.reloadData()
        AdsCollectionView.reloadData()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem?.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        homeViewModel.brandsClosure = { [weak self] res in
            DispatchQueue.main.async { [weak self] in
                NetworkIndicator.stopAnimation()
                self?.brandsArray = res
                print("", self?.brandsArray[0].title)
                self?.brandsCollectionView.reloadData()
            }
                print("User id Home: \(User.id)")
        }
        homeViewModel.getBrands()
        
        setupNavigationBarIcons()
        

        
        actionButton.addItem(title: "New Item", image: UIImage(named: "plusIcon"), action: { item in
            
        })
        startAdsAutoScrolling()
    }
    
    deinit {
        adsScrollTimer?.invalidate()
    }

    func startAdsAutoScrolling() {
        adsScrollTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollAdsCollectionView), userInfo: nil, repeats: true)
    }

    @objc func scrollAdsCollectionView() {
        let visibleItems = AdsCollectionView.indexPathsForVisibleItems.sorted()
        guard let currentItem = visibleItems.first else { return }

        var nextItem = IndexPath(item: currentItem.item + 1, section: currentItem.section)
        if nextItem.item >= imageNames.count {
            nextItem = IndexPath(item: 0, section: currentItem.section)
        }

        AdsCollectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
    }
    
    func setupNavigationBarIcons() {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.spacing = 10
         stackView.alignment = .center
         stackView.distribution = .equalSpacing
         
        let button1 = UIButton(type: .system)
        setUpNavBarBtn(button: button1, imageName: "searchIcons", selector: #selector(icon1Tapped))

        let button2 = UIButton(type: .system)
        setUpNavBarBtn(button: button2, imageName: "like", selector: #selector(icon2Tapped))
      
        let button3 = UIButton(type: .system)
        setUpNavBarBtn(button: button3, imageName: "shoppingCart", selector: #selector(icon3Tapped))
    
         stackView.addArrangedSubview(button1)
         stackView.addArrangedSubview(button2)
         stackView.addArrangedSubview(button3)
         
         let barButtonItem = UIBarButtonItem(customView: stackView)

        tabBarController?.navigationItem.rightBarButtonItem = barButtonItem
        
        tabBarController?.navigationItem.hidesBackButton = true
        tabBarController?.navigationItem.backBarButtonItem?.isHidden = true
        tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
     }
    
    @objc func icon1Tapped() {
                        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
                        let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "SearchViewController"))
                        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    
    @objc func icon2Tapped() {
                        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
                        let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "FavoriteViewController"))
                        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    
    @objc func icon3Tapped() {
        let cart = CartViewController()
        self.navigationController?.pushViewController(cart, animated: true)
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
            
 
            cell.adsImage.image = UIImage(named: imageNames[indexPath.item])
             
            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            cell.cellImage.sd_setImage(with: URL(string: brandsArray[indexPath.item].image.src ?? ""), placeholderImage: UIImage(named: "processing"))
             
            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
        }
    }

}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("navigationController")
        
        if collectionView == brandsCollectionView {
            
            
            let brandDetails = storyboard?.instantiateViewController(withIdentifier: "BrandDetailViewController") as? BrandDetailViewController
            brandDetails?.collectionIdStr = brandsArray[indexPath.item].id
            brandDetails?.collectionTitle = brandsArray[indexPath.item].title
            navigationController?.pushViewController(brandDetails!, animated: true)
        }else{
            
        }
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
    func setUpNavBarBtn(button: UIButton, imageName: String, selector: Selector) {
      
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .systemOrange
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

}

