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
    
    var objCompany : Drink? {
        didSet {
            noodleName.text = objCompany?.flavour

            if ((UIImage(named: ((objCompany?.brand)!+"-"+(objCompany?.flavour)!).lowercased())) != nil){
                noodlePicture.image = UIImage(named: ((objCompany?.brand)!+"-"+(objCompany?.flavour)!).lowercased())
                
            }else{
                noodlePicture.image = UIImage(named: "Default")
            }
            noodleQunatity.text = String(describing: objCompany!.count)
            manageBackGroundColor()
        }
    }
    
    
    var clickComplition : ((_ totalCount:Int,_ cellIndex:Int) -> Void)? = nil
    
    @IBAction func noodlePlus(_ sender: Any) {
        increnmentValue()
    }
    
    @IBAction func noodleMinus(_ sender: Any) {
        decrementValue()
    }
    
    public func increnmentValue() {
        var count:Int = Int(noodleQunatity.text!)!
        
        if count < 3 {
            count = count + 1
            updateStatus(count: count)
            callComplition()
        }
    }
    
    public func decrementValue()  {
        var count:Int = Int(noodleQunatity.text!)!
        
        if count > 0 {
            count = count - 1
            updateStatus(count: count)
            callComplition()
        }
        
    }
    
    public func updateStatus(count: Int) {
        objCompany?.count = count
        noodleQunatity.text = "\(count)"
        manageBackGroundColor()
    }
    
    private func callComplition() {
        guard clickComplition != nil else {
            return
        }
        clickComplition!((objCompany?.count)!, tag)
        
    }
    
    private func manageBackGroundColor() {
        let count:Int = Int(noodleQunatity.text!)!
        
        if count > 0 {
            makeHilighted()
        } else {
            makeNormal()
        }
    }
}
