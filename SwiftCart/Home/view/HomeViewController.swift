
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
    var couponsList : [DiscountCodes] = []
    var cartItemCount = 0 {
           didSet {
               updateBadge()
           }
       }
    let badgeLabel = UILabel()

    

    @IBOutlet weak var AdsCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    @IBOutlet var brandWordLabel: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        setBackground(view: self.view)
       // Setup collection view
        CollectionViewDesign.collectionView(colView: brandsCollectionView)
        CollectionViewDesign.collectionView(colView: AdsCollectionView)
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        AdsCollectionView.dataSource = self
        AdsCollectionView.delegate = self
        brandsCollectionView.reloadData()
        AdsCollectionView.reloadData()
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.backBarButtonItem?.isHidden = true
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Get data of brands
        homeViewModel.brandsClosure = { [weak self] res in
            DispatchQueue.main.async { [weak self] in
                self?.brandsArray = res
                print("", self?.brandsArray[0].title)
                self?.brandsCollectionView.reloadData()
            }
                print("User id Home: \(User.id)")
        }
        
        homeViewModel.getBrands()
        homeViewModel.getDiscountCodes()
        
        setupNavigationBarIcons()
        homeViewModel.discountCodesClosure = {[weak self] in
                    guard let self = self else {return}
                    self.couponsList = self.homeViewModel.couponsResult!
                    self.renderView()
                }
        

        
        actionButton.addItem(title: "New Item", image: UIImage(named: "plusIcon"), action: { item in
            
        })
    }
    func renderView(){
            DispatchQueue.main.async {
              //  self.brandsCollection.reloadData()
                self.AdsCollectionView.reloadData()
            }
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.hidesBackButton = true

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
    
        setupBadgeLabel(on: button3)

        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)

        let barButtonItem = UIBarButtonItem(customView: stackView)
        tabBarController?.navigationItem.rightBarButtonItem = barButtonItem
        
        tabBarController?.navigationItem.hidesBackButton = true
        tabBarController?.navigationItem.backBarButtonItem?.isHidden = true
        tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
           }

    func setupBadgeLabel(on button: UIButton) {
        badgeLabel.backgroundColor = .red
        badgeLabel.textColor = .white
        badgeLabel.font = .systemFont(ofSize: 12)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.isHidden = true
        button.addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            badgeLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: -5),
            badgeLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 5)
        ])
    }

    func updateBadge() {
           badgeLabel.text = "\(cartItemCount)"
           badgeLabel.isHidden = cartItemCount == 0
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
         let cart = NewCartViewController()
         cart.cartItemCountUpdated = { [weak self] count in
             self?.cartItemCount = count
         }
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
            return couponsList.count
        } else {
            return brandsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == AdsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddsCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            // Cell data
           // cell.adsLabel.text = "50%"
            
            if(!couponsList.isEmpty){
                print("!couponsList!.isEmpty")
                cell.adsLabel.text = couponsList[indexPath.row].code
                cell.adsImage.image = UIImage(named: imageNames[indexPath.item])
                
                if(indexPath.row < imageNames.count){
                    //var index = 0
                    cell.adsImage.image = UIImage(named: imageNames[indexPath.row])
                    //   index += 1
                }else{
                    cell.adsImage.image = UIImage(named: imageNames[3])
                }
                
                
                CollectionViewDesign.collectionViewCell(cell: cell)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            // Cell data
           // cell.cellLabel.text = brandsArray[indexPath.item].title
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

