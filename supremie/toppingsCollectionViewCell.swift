//
//  toppingsCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class toppingsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageStock: UIImageView!
    @IBOutlet weak var toppingsPicture: UIImageView!
    @IBOutlet weak var toppingsName: UILabel!
    @IBOutlet weak var toppingsQuantity: UILabel!
    @IBOutlet weak var toppingPrice: UILabel!
    
    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    
    var objTopping:Topping? {
        didSet {
            if ((UIImage(named: (objTopping?.imgUrl)!)) != nil){
                toppingsPicture.image = UIImage(named: (objTopping?.imgUrl)!)
            }else{
                toppingsPicture.image = UIImage(named: "Default")
            }
            
            toppingsName.text =  objTopping!.name
            toppingsQuantity.text = String(describing: objTopping!.count)
            manageBackGroundColor()
            manageStock()
        }
    }
    
    
    @IBAction func toppingsPlus(_ sender: Any) {
        
        increnmentValue()
    }
    
    @IBAction func toppingsMinus(_ sender: Any) {
        
        decrementValue()
    }
    
    public func increnmentValue() {
        var count:Int = Int(toppingsQuantity.text!)!
        
        if count < 3 {
            count = count + 1
            updateStatus(count: count)
            callComplition()
        }
    }
    
    public func decrementValue()  {
        var count:Int = Int(toppingsQuantity.text!)!
        
        if count > 0 {
            count = count - 1
            updateStatus(count: count)
            callComplition()
        }
        
    }
    
    public func updateStatus(count: Int) {
        objTopping?.count = count
        toppingsQuantity.text = "\(count)"
        manageBackGroundColor()
    }
    
    private func callComplition() {
        guard clickComplition != nil else {
            return
        }
        clickComplition!((objTopping?.count)!, tag)
        
    }
    
    private func manageBackGroundColor() {
        let count:Int = Int(toppingsQuantity.text!)!
        
        if count > 0 {
            makeHilighted()
        } else {
            makeNormal()
        }
    }
    
    private func manageStock() {
        if (objTopping?.stock)! > 0 {
            imageStock.isHidden = true
            self.isUserInteractionEnabled = true
        } else {
            imageStock.isHidden = false
            self.isUserInteractionEnabled = false
        }
    }
}
