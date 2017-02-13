//
//  MemeCollectionViewCell.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 2/8/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeCellImageView: UIImageView!
    
    func getCellMeme(_ image: UIImage) {
        
        memeCellImageView.image = image
        
    }
}
