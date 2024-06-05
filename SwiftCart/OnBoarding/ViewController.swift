//
//  ViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 23/05/2024.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var horizontalScrollOnBoarding: UIView!
    let scrollView = UIScrollView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !OnBoardingManager.shared.isNewuser() {

            navigate()

        }
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configure(){
        scrollView.frame = horizontalScrollOnBoarding.bounds
        horizontalScrollOnBoarding.backgroundColor = UIColor(named: "ScreenAndUIText")
        horizontalScrollOnBoarding.addSubview(scrollView)
        let titles = ["Trendy Products","Items Delivery"]
        for x in 0..<2 {
            
            let page = UIView(frame: CGRect(x: CGFloat(x) * horizontalScrollOnBoarding.frame.size.width, y: 0, width: horizontalScrollOnBoarding.frame.size.width, height: horizontalScrollOnBoarding.frame.size.height))
            
            scrollView.addSubview(page)
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: page.frame.size.width-20, height: 120))
            let animationView = LottieAnimationView()
                    animationView.animation = LottieAnimation.named("onBoarding_\(x+1)")
                    animationView.frame = CGRect(x: 0, y: 0, width: page.frame.size.width, height: page.frame.size.height)
                    animationView.loopMode = .loop
                    view.addSubview(animationView)
                    animationView.play()
            
            let button = UIButton(frame: CGRect(x: 10, y: page.frame.size.height-60, width: page.frame.size.width-20, height: 50))
            
            
            animationView.contentMode = .scaleAspectFit
            page.addSubview(animationView)
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            label.textColor = UIColor(named: "HintTextAndIcon")
            label.text = titles[x]
            page.addSubview(label)
            
            button.setTitleColor(UIColor(named: "ScreenAndUIText"), for: .normal)
            button.backgroundColor = UIColor(named: "UIButtonsAndText")
            button.setTitle("Continue", for: .normal)
            if x == 1 {
                button.setTitle("Get Started", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.tag = x+1
            page.addSubview(button)

            
            scrollView.contentSize = CGSize(width: horizontalScrollOnBoarding.frame.size.width*2, height: 0)
            scrollView.isPagingEnabled = true
            
            
        }
    }

    @objc func didTapButton(_ button:UIButton){
        guard button.tag < 2 else{
            OnBoardingManager.shared.setIsNotNewUser()
            navigate()
            return
        }
        scrollView.setContentOffset(CGPoint(x: horizontalScrollOnBoarding.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }
    
    func navigate(){
        let authenticationStoryBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let mainAuthVC = authenticationStoryBoard.instantiateViewController(withIdentifier: "MainAuthViewController")
        self.navigationController?.pushViewController(mainAuthVC, animated: true)
    }


}

