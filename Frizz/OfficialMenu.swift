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
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupLayout () {
        pages = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 70, width: UIScreen.main.bounds.width, height: 50))
        pages.numberOfPages = 4
        pages.currentPage = 0
        pages.tintColor = .black
        pages.pageIndicatorTintColor = .gray
        pages.currentPageIndicatorTintColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        view.addSubview(pages)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let pageViewController as PageViewController:
            pageViewController.pagingDelegate = self
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
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        case 1:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        case 2:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.6467822194, blue: 0, alpha: 1)
        case 3:
            pages.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        default:
            pages.currentPageIndicatorTintColor = .black
        }
    }
}
