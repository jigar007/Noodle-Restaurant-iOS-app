//
//  drinksCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class drinksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageStock: UIImageView!
    @IBOutlet weak var drinksPicture: UIImageView!
    @IBOutlet weak var drinksName: UILabel!
    @IBOutlet weak var drinksQunatity: UILabel!
    @IBOutlet weak var drinksPrice: UILabel!
    
    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    
    var objDrinks : Drink? {
        didSet {
            if ((UIImage(named: ((objDrinks?.brand)!).lowercased())) != nil){
                drinksPicture.image = UIImage(named: ((objDrinks?.brand)!).lowercased())
            }else{
                drinksPicture.image = UIImage(named: "Default")
            }
            
            drinksName.text =  (objDrinks?.brand)!
            drinksQunatity.text = String(describing: objDrinks!.count)
            manageBackGroundColor()
            manageStock()
        }
    }
    
    
    @IBAction func drinksPlus(_ sender: Any) {
        
        increnmentValue()
    }
    
    @IBAction func drinksMinus(_ sender: Any) {
        
       decrementValue()
    }
    public func increnmentValue() {
        var count:Int = Int(drinksQunatity.text!)!
        
        if count < 3 {
            count = count + 1
            updateStatus(count: count)
            callComplition()
        }
    }
    
    public func decrementValue()  {
        var count:Int = Int(drinksQunatity.text!)!
        
        if count > 0 {
            count = count - 1
            updateStatus(count: count)
            callComplition()
        }
    }
    
    public func updateStatus(count: Int) {
        objDrinks?.count = count
        drinksQunatity.text = "\(count)"
        manageBackGroundColor()
    }
    
    private func callComplition() {
        guard clickComplition != nil else {
            return
        }
        clickComplition!((objDrinks?.count)!, tag)
        
    }
    
    private func manageBackGroundColor() {
        let count:Int = Int(drinksQunatity.text!)!
        
        if count > 0 {
            makeHilighted()
        } else {
            makeNormal()
        }
    }
    
    private func manageStock() {
        if (objDrinks?.stock)! > 0 {
            imageStock.isHidden = true
            self.isUserInteractionEnabled = true
        } else {
            imageStock.isHidden = false
            self.isUserInteractionEnabled = false
        }
    }
}
