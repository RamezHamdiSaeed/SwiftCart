
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
    
    var homeViewModel = HomeViewModel(networkService: NetworkServicesImpl())
    var brandsArray: [SmartCollection] = []
    let actionButton = JJFloatingActionButton()
    let imageNames = ["60", "50", "10", "15", "25"]
    var couponsList: [DiscountCodes] = []
    var cartItemCount = 0 {
        didSet {
            updateBadge()
        }
    }
    let badgeLabel = UILabel()
    
    @IBOutlet weak var indicatoroutlet: UIActivityIndicatorView!
    
    @IBOutlet weak var AdsCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    @IBOutlet var brandWordLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        indicatoroutlet.startAnimating()
        
        setBackground(view: self.view)
        
        CollectionViewDesign.collectionView(colView: brandsCollectionView)
        //CollectionViewDesign.collectionView(colView: AdsCollectionView)
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        AdsCollectionView.dataSource = self
        AdsCollectionView.delegate = self
        brandsCollectionView.reloadData()
        AdsCollectionView.reloadData()
        
        homeViewModel.brandsClosure = { [weak self] res in
            DispatchQueue.main.async { [weak self] in
                self?.brandsArray = res
                self?.brandsCollectionView.reloadData()
                self?.indicatoroutlet.stopAnimating()
            }
        }
        
        homeViewModel.getBrands()
        homeViewModel.getDiscountCodes()
        
        setupNavigationBarIcons()
        setupLeftBarButtonItem()
        
        homeViewModel.discountCodesClosure = { [weak self] in
            guard let self = self else { return }
            self.couponsList = self.homeViewModel.couponsResult!
            self.renderView()
        }
        
        actionButton.addItem(title: "New Item", image: UIImage(named: "plusIcon"), action: { item in
        })
    }
    
    func renderView() {
        DispatchQueue.main.async {
            self.AdsCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        setUpNavBarBtn(button: button2, imageName: "like", selector: #selector(favTapped))
        
        let button3 = UIButton(type: .system)
        setUpNavBarBtn(button: button3, imageName: "shoppingCart", selector: #selector(cartTapped))
        
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
    
    func setupLeftBarButtonItem() {
        let trendyLabel = UILabel()
        trendyLabel.text = "Trendy"
        trendyLabel.textColor = .systemOrange
        trendyLabel.font = .boldSystemFont(ofSize: 20)
        
             if let customFont = UIFont(name: "HoeflerText-Italic", size: 30) {
                 trendyLabel.font = customFont
             } else {
                 trendyLabel.font = .boldSystemFont(ofSize: 30)
             }
             
             trendyLabel.layer.shadowColor = UIColor.black.cgColor
             trendyLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
             trendyLabel.layer.shadowOpacity = 0.3
             trendyLabel.layer.shadowRadius = 2
        
        let trendyBarButtonItem = UIBarButtonItem(customView: trendyLabel)
        tabBarController?.navigationItem.leftBarButtonItem = trendyBarButtonItem
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
        let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
        let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "SearchViewController"))
        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    
    @objc func favTapped() {
        if User.id == nil {
            AppCommon.feedbackManager.showAlert(alertTitle: "", alertMessage: "You need to Log In", alertStyle: .alert, view: self)
        } else {
            let productsSearchDetailsAndFav = UIStoryboard(name: "ProductsSearchDetailsAndFav", bundle: nil)
            let SearchViewController = (productsSearchDetailsAndFav.instantiateViewController(withIdentifier: "FavoriteViewController"))
            self.navigationController?.pushViewController(SearchViewController, animated: true)
        }
    }
    
    @objc func cartTapped() {
        if User.id == nil {
            AppCommon.feedbackManager.showAlert(alertTitle: "", alertMessage: "You need to Log In", alertStyle: .alert, view: self)
        } else {
            let cart = NewCartViewController()
            cart.cartItemCountUpdated = { [weak self] count in
                self?.cartItemCount = count
            }
            self.navigationController?.pushViewController(cart, animated: true)
        }
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
            
            if !couponsList.isEmpty {
                cell.adsLabel.text = couponsList[indexPath.row].code
                
                if indexPath.row < imageNames.count {
                    cell.adsImage.image = UIImage(named: imageNames[indexPath.row])
                } else {
                    cell.adsImage.image = UIImage(named: imageNames[3])
                }

                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                cell.adsImage.addGestureRecognizer(tapGesture)
                cell.adsImage.isUserInteractionEnabled = true
                cell.adsImage.tag = indexPath.row

                CollectionViewDesign.collectionViewCell(cell: cell)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            
            cell.cellImage.sd_setImage(with: URL(string: brandsArray[indexPath.item].image.src ?? ""), placeholderImage: UIImage(named: "processing"))

            CollectionViewDesign.collectionViewCell(cell: cell)
            return cell
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        let index = tappedImageView.tag
        let code = couponsList[index].code
        UIPasteboard.general.string = code
        print("Coupon code \(code) copied to clipboard")
        
        // Optionally, show a message to the user
        let alert = UIAlertController(title: "Copied", message: "Coupon code  copied ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandsCollectionView {
            let brandDetails = storyboard?.instantiateViewController(withIdentifier: "BrandDetailViewController") as? BrandDetailViewController
            brandDetails?.collectionIdStr = brandsArray[indexPath.item].id
            brandDetails?.collectionTitle = brandsArray[indexPath.item].title
            navigationController?.pushViewController(brandDetails!, animated: true)
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
