//
//  MemeTableViewCell.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 2/9/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableViewLabel: UILabel!
    @IBOutlet weak var tableViewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getMemeTableViewImage(_ image: UIImage) {
        tableViewImage.image = image
    }
    
    func getMemeTableViewTexts(_ texts: String) {
                
    }
    
    
}
