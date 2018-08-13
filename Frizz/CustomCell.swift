//
//  customCell.swift
//  Frizz
//
//  Created by Reem Amer on 8/9/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var index: Int?
    var data: [String : [CellContent]]?
    var type: String?
    lazy var typeContent = data![type!]
    lazy var currentItem = typeContent![index!]
    
    @IBOutlet weak var itemsCounter: UILabel!
    
    @IBAction func plusButton(_ sender: UIButton) {
        currentItem.count += 1
        itemsCounter.text = String(currentItem.count)
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        if currentItem.count != 0 {
            currentItem.count -= 1
            itemsCounter.text = String(currentItem.count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        itemsCounter.text = String(currentItem.count)
    }
}
