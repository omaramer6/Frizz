//
//  OfficialMenu.swift
//  Frizz
//
//  Created by Reem Amer on 8/5/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

enum Colors {
    
    static let red = UIColor(red: 1.0, green: 0.0, blue: 77.0/255.0, alpha: 1.0)
    static let blue = UIColor.blue
    static let green = UIColor(red: 35.0/255.0 , green: 233/255, blue: 173/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 1, green: 209/255, blue: 77.0/255.0, alpha: 1.0)
}

enum Images {
    
    static let box = UIImage(named: "Box")!
    static let triangle = UIImage(named: "Triangle")!
    static let circle = UIImage(named: "Circle")!
    static let swirl = UIImage(named: "Spiral")!
}

class OfficialMenu: UIViewController, PaginingDelegate {
    
    var name: String?
    var phone: String?
    var pages = UIPageControl()
    var emitter = CAEmitterLayer()
    var colors:[UIColor] = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow
    ]
    var images:[UIImage] = [
        Images.box,
        Images.triangle,
        Images.circle,
        Images.swirl
    ]
    var velocities:[Int] = [
        100,
        90,
        150,
        200
    ]
    
    let nameLabelView: UILabel = {
        let nameView = UILabel()
        nameView.font = UIFont.boldSystemFont(ofSize: 20)
        nameView.font = UIFont(name: "Avenir-Roman", size: 30)
        nameView.textAlignment = .left
        nameView.textColor = .black
        nameView.translatesAutoresizingMaskIntoConstraints = false
        return nameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nameLabelView)
        
        nameLabelView.text = "Hi, " + name! + "!"
        
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        emitter.emitterCells = generateEmitterCells()
        self.view.layer.addSublayer(emitter)
        self.view.layer.insertSublayer(emitter, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fadeViewInThenOut(view: nameLabelView, delay: 0.75)
    }
    
    
    
    
    func setupLayout () {
        nameLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        nameLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pages = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 70, width: UIScreen.main.bounds.width, height: 50))
        pages.numberOfPages = 4
        pages.currentPage = 0
        pages.tintColor = .black
        pages.pageIndicatorTintColor = .gray
        pages.currentPageIndicatorTintColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        view.addSubview(pages)
    }
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 0.25
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 1
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            
            UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                view.alpha = 0
            },
                           completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let pageViewController as PageViewController:
            pageViewController.pagingDelegate = self
        default:
            break
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
    
    
    //Not my code... Just for fun!
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16 {
            
            let cell = CAEmitterCell()
            
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.25
            cell.scale = 0.1
            
            cells.append(cell)
            
        }
        
        return cells
        
    }
    
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func getNextColor(i:Int) -> CGColor {
        if i <= 4 {
            return colors[0].cgColor
        } else if i <= 8 {
            return colors[1].cgColor
        } else if i <= 12 {
            return colors[2].cgColor
        } else {
            return colors[3].cgColor
        }
    }
    
    private func getNextImage(i:Int) -> CGImage {
        return images[i % 4].cgImage!
    }
}
