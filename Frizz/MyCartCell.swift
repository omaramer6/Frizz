//
//  MyCartCell.swift
//  Frizz
//
//  Created by Reem Amer on 8/15/18.
//  Copyright © 2018 Building Something Cool. All rights reserved.
//

import UIKit

class MyCartCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQTY: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
