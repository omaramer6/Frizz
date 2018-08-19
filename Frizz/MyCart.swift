//
//  MyCart.swift
//  Frizz
//
//  Created by Reem Amer on 8/12/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class MyCart: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nameArray = [String]()
    var priceArray = [Double]()
    var countArray = [Int]()
    static var sum: Double = 0.0
    var effect: UIVisualEffect!
    var name: String?
    var phone: String?
    
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var paymentView: UIView!
    @IBOutlet var doneView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var dismissCartButton: UIButton!
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var tableViewCart: UITableView!
    @IBAction func dismissCart(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissUIView(_ sender: UIButton) {
        animatePaymentViewOut()
    }
    @IBAction func checkOut(_ sender: UIButton) {
        animatePaymentViewIn()
    }
    @IBAction func cashPayment(_ sender: UIButton) {
        if tableViewCart.visibleCells.isEmpty{
            print("Can't checkout... You have to order something")
        } else {
            animatePaymentViewOut()
            animateDoneViewIn()
        }
    }
    @IBAction func doneWithOrder(_ sender: UIButton) {
        animateDoneViewOut()
        reset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        paymentView.layer.cornerRadius = 12
        doneView.layer.cornerRadius = 12
        
        tableViewCart.delegate = self
        tableViewCart.dataSource = self
        
        for (_, value) in MenuViewController.data {
            for x in 0..<value.count {
                if value[x].count != 0 {
                    nameArray.append(value[x].name)
                    priceArray.append(value[x].price)
                    countArray.append(value[x].count)
                }
            }
        }
        
        MyCart.sum = 0.0
        _ = (0..<priceArray.count).map {
            MyCart.sum += priceArray[$0] * Double(countArray[$0])
        }
        
        totalPrice.text = String(MyCart.sum)
    }
    
    private func reset () {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        for (_, value) in MenuViewController.data {
            for x in 0..<value.count {
                if value[x].count != 0 {
                    value[x].count = 0
                }
            }
        }
    }
    
    func animateDoneViewIn () {
        self.view.addSubview(doneView)
        nameLabel.text = name
        totalLabel.text = String(MyCart.sum) + " EGP"
        self.doneView.addSubview(nameLabel)
        self.doneView.addSubview(totalLabel)
        doneView.center = self.view.center
        
        doneView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        doneView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.doneView.alpha = 1
            self.doneView.transform = CGAffineTransform.identity
        }
        
        dismissCartButton.isEnabled = false
        proceedToCheckoutButton.isEnabled = false
    }
    
    func animateDoneViewOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.doneView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.doneView.alpha = 0
            
        }) { (success: Bool) in
            self.doneView.removeFromSuperview()
        }
        
        proceedToCheckoutButton.isEnabled = true
        dismissCartButton.isEnabled = true
    }
    
    func animatePaymentViewIn() {
        self.view.addSubview(paymentView)
        paymentView.center = self.view.center
        
        paymentView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        paymentView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.paymentView.alpha = 1
            self.paymentView.transform = CGAffineTransform.identity
        }
        
        proceedToCheckoutButton.isEnabled = false
        dismissCartButton.isEnabled = false
    }
    
    func animatePaymentViewOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.paymentView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.paymentView.alpha = 0
            
        }) { (success: Bool) in
            self.paymentView.removeFromSuperview()
        }
        
        proceedToCheckoutButton.isEnabled = true
        dismissCartButton.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCartCell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! MyCartCell
        
        cell.itemName.text = nameArray[indexPath.row]
        cell.itemQTY.text = String(countArray[indexPath.row])
        cell.itemPrice.text = String(priceArray[indexPath.row] * Double(countArray[indexPath.row]))
        cell.isUserInteractionEnabled = false
        
        return cell
    }
}
