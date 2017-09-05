//
//  CompanyCollectionViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var company: UIImageView!
    
    var objDrink : Drink? {
        didSet {
            if ((UIImage(named: (objDrink?.brand)!)) != nil){
                company.image = UIImage(named: (objDrink?.brand)!)
            }else{
                company.image = UIImage(named: "Default")
            }
        }
    }
    
}
