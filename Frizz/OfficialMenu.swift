//
//  OfficialMenu.swift
//  Frizz
//
//  Created by Reem Amer on 8/5/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class OfficialMenu: UIViewController, PaginingDelegate, UIViewControllerTransitioningDelegate {
    
    var name: String?
    var phone: String?
    var buttonPressed: String?
    var pages = UIPageControl()
    
    let transition = CircularTransition()
    
    
    @IBOutlet weak var sauceView: UIView!
    @IBOutlet weak var dessertView: UIView!
    @IBOutlet weak var fizzView: UIView!
    @IBOutlet weak var friesView: UIView!
    @IBOutlet weak var cartButton: UIButton!
    
    @IBAction func buttonFries(_ sender: UIButton) {
        buttonPressed = "FriesButton"
    }
    @IBAction func buttonFizz(_ sender: UIButton) {
        buttonPressed = "FizzButton"
    }
    @IBAction func buttonDessert(_ sender: UIButton) {
        buttonPressed = "DessertButton"
    }
    @IBAction func buttonSauce(_ sender: UIButton) {
        buttonPressed = "SauceButton"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if friesView != nil {
            friesView.setGradientBackground(colorOne: UIColor.lightGray, colorTwo: UIColor.red)
        }
        if fizzView != nil {
            fizzView.setGradientBackground(colorOne: UIColor.lightGray, colorTwo: UIColor.blue)
        }
        if dessertView != nil {
            dessertView.setGradientBackground(colorOne: UIColor.white, colorTwo: UIColor.magenta)
        }
        if sauceView != nil {
            sauceView.setGradientBackground(colorOne: Colors.red, colorTwo: Colors.orange)
        }
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = cartButton.center
        transition.cirlceColor = cartButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = cartButton.center
        transition.cirlceColor = cartButton.backgroundColor!
        
        return transition
    }
    
    func setupLayout () {
        pages = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 70, width: UIScreen.main.bounds.width, height: 50))
        pages.numberOfPages = 4
        pages.currentPage = 0
        pages.tintColor = .black
        pages.pageIndicatorTintColor = .gray
        pages.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        view.addSubview(pages)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let pageViewController as PageViewController:
            pageViewController.pagingDelegate = self
        case let myCart as MyCart:
            myCart.transitioningDelegate = self
            myCart.modalPresentationStyle = .custom
            myCart.name = name
            myCart.phone = phone
        default:
            break
        }
        
        let data = buttonPressed
        if let destinationViewController = segue.destination as? MenuViewController {
            destinationViewController.origin = data
        }
    }
    
    func onIndexChanged(newIndex: Int) {
        pages.currentPage = newIndex
        switch pages.currentPage {
        case 0:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case 1:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        case 2:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        case 3:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        default:
            pages.currentPageIndicatorTintColor = .black
        }
    }
}

extension UIView {
    func setGradientBackground (colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

