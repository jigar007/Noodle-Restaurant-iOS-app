//
//  drinksCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class drinksCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var drinksPicture: UIImageView!
    @IBOutlet weak var drinksName: UILabel!
    @IBOutlet weak var drinksQunatity: UILabel!
    
    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    
    @IBAction func drinksPlus(_ sender: Any) {
        
        var count:Int = Int(drinksQunatity.text!)!
         if count < 2 {
            count = count + 1
            drinksQunatity.text = "\(count)"
            updateStatus(count: count)
        }
    }
    
    @IBAction func drinksMinus(_ sender: Any) {
        
        var count:Int = Int(drinksQunatity.text!)!
        
        if count > 0 {
            count = count - 1
            drinksQunatity.text = "\(count)"
            updateStatus(count: count)
        }
        
    }
    private func updateStatus(count: Int) {
        
        guard clickComplition != nil else {
            return
        }
        clickComplition!(count, tag)
    }
}
