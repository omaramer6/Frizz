//
//  MenuViewController.swift
//  Frizz
//
//  Created by Reem Amer on 8/2/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class CellContent {
    var name: String
    var price: String
    var count: Int
    
    init(name: String, price: String, count: Int) {
        self.name = name
        self.price = price
        self.count = count
    }
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "LabelCell"
    
    var tableContent = Array<CellContent>()
    var type: String?
    var origin: String? {
        didSet {
            if let dataReceived = origin {
                switch dataReceived {
                case "FriesButton":
                    type = "Fries"
                case "FizzButton":
                    type = "Fizz"
                case "DessertButton":
                    type = "Dessert"
                case "SauceButton":
                    type = "Sauce"
                default:
                    break
                }
            }
        }
    }
    
    
    static var contentFries = [CellContent(name: "French Fries", price: "10.00 EGP", count: 0),
                               CellContent(name: "Cheese Fries", price: "15.00 EGP", count: 0),
                               CellContent(name: "Curly Fries", price: "20.00 EGP", count: 0),
                               CellContent(name: "Wedges", price: "18.00 EGP", count: 0)]
    
    static var contentFizz = [CellContent(name: "CocaCola", price: "12.00 EGP", count: 0),
                              CellContent(name: "Miranda", price: "12.00 EGP", count: 0),
                              CellContent(name: "Sprite", price: "12.00 EGP", count: 0),
                              CellContent(name: "Mountain Dew", price: "12.00 EGP", count: 0),
                              CellContent(name: "Schweppes Gold", price: "15.00 EGP", count: 0)]
    
    static var contentDessert = [CellContent(name: "Ice-Cream", price: "12.00 EGP", count: 0),
                                 CellContent(name: "Waffles", price: "20.00 EGP", count: 0)]
    
    static var contentSauce = [CellContent(name: "Ketchup", price: "5.00 EGP", count: 0),
                               CellContent(name: "Mayo", price: "5.00 EGP", count: 0),
                               CellContent(name: "Honey Mustard", price: "5.00 EGP", count: 0),
                               CellContent(name: "BBQ", price: "5.00 EGP", count: 0),
                               CellContent(name: "Jalapeno Cheese", price: "5.00 EGP", count: 0)]
    
    static var data : [String:[CellContent]] = ["Fries" : contentFries,
                                                "Fizz" : contentFizz,
                                                "Dessert": contentDessert,
                                                "Sauce" : contentSauce]
    //TODO: use enums
    func prepareContent() -> [CellContent] {
        switch origin {
        case "FriesButton":
            return MenuViewController.contentFries
        case "FizzButton":
            return MenuViewController.contentFizz
        case "DessertButton":
            return MenuViewController.contentDessert
        case "SauceButton":
            return MenuViewController.contentSauce
        default:
            return []
        }
    }
    
    @IBOutlet weak var tableViewer: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableContent = prepareContent()
        
        tableViewer.delegate = self
        tableViewer.dataSource = self
        
    }
    
    @IBAction func closeSubMenu(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        let item = tableContent[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.price
        cell.textLabel?.font = UIFont .systemFont(ofSize: 20.00)
        cell.detailTextLabel?.font = UIFont .systemFont(ofSize: 14.00)
        cell.index = indexPath.row
        cell.type = type
        cell.data = MenuViewController.data
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}
