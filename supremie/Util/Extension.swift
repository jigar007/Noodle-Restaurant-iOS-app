
//
//  Extension.swift
//  supremie
//
//  Created by Aman Prajapati on 9/8/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func makeHilighted()  {
        self.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
    }
    
    func makeNormal()  {
        self.backgroundColor = UIColor.white
    }
}
