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
    
    @IBAction func noodlePlus(_ sender: Any) {
       
        var count:Int = Int(noodleQunatity.text!)!
        
        if count < 3 {
            count = count + 1
            noodleQunatity.text = "\(count)"
            updateStatus(count: count)
        }
        
    }
    
    
    @IBAction func noodleMinus(_ sender: Any) {
        
        var count:Int = Int(noodleQunatity.text!)!

        if count > 0 {
            count = count - 1
            noodleQunatity.text = "\(count)"
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
