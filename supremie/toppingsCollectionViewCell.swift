//
//  toppingsCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class toppingsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var toppingsPicture: UIImageView!
    @IBOutlet weak var toppingsName: UILabel!
    @IBOutlet weak var toppingsQuantity: UILabel!

    @IBAction func toppingPlusMinus(_ sender: Any) {
    }
}
