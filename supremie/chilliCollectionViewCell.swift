//
//  chilliCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class chilliCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var chilliPicture: UIImageView!
    @IBOutlet weak var chilliName: UILabel!
    @IBOutlet weak var chilliQunatity: UILabel!
    
    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    
    @IBAction func chilliPlus(_ sender: Any) {
        
        var count:Int = Int(chilliQunatity.text!)!
        
        if count < 3 {
            count = count + 1
            chilliQunatity.text = "\(count)"
            updateStatus(count: count)
        }
    }
    
    @IBAction func chilliMinus(_ sender: Any) {
        
        var count:Int = Int(chilliQunatity.text!)!
        
        if count > 0 {
            count = count - 1
            chilliQunatity.text = "\(count)"
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
