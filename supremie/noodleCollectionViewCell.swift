//
//  noodleCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class noodleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var noodlePicture: UIImageView!
    @IBOutlet weak var noodleName: UILabel!
    @IBOutlet weak var noodleQunatity: UILabel!

    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    var count = 0
    
    @IBAction func noodlePlus(_ sender: Any) {
        if count < 3 {
            count = count + 1
            updateStatus()
        }
        
    }
    
    
    @IBAction func noodleMinus(_ sender: Any) {
        
        if count > 0 {
            count = count - 1
            updateStatus()
        }
        
    }
    private func updateStatus() {
        noodleQunatity.text = "\(count)"
        
        guard clickComplition != nil else {
            return
        }
        
        clickComplition!(count, tag)
    }
    
}
