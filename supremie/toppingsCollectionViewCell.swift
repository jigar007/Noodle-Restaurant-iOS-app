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
    
    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    
    @IBAction func toppingsPlus(_ sender: Any) {
        
        var count:Int = Int(toppingsQuantity.text!)!
        
        if count < 3 {
            count = count + 1
            toppingsQuantity.text = "\(count)"
            updateStatus(count: count)
        }
    }
    
    @IBAction func toppingsMinus(_ sender: Any) {
        
        var count:Int = Int(toppingsQuantity.text!)!
        
        if count > 0 {
            count = count - 1
            toppingsQuantity.text = "\(count)"
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
