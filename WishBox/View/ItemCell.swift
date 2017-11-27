//
//  ItemCell.swift
//  WishBox
//
//  Created by Shehryar Khan on 27.11.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var price: UILabel!
    @IBOutlet var thumb: UIImageView!
    
    @IBOutlet var details: UILabel!
    @IBOutlet var title: UILabel!
    
    func configureCell(item: Item) {
        
        title.text = item.title
        price.text = "€\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        
    }
}
