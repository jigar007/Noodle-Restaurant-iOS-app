//
//  SingletoneHandler.swift
//  supremie
//
//  Created by Aman Prajapati on 9/2/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import Foundation

class InfoDetail {
    
    static let sharedInstant:InfoDetail = InfoDetail()
    static var selectedName:String = ""
    var objItem:Mie!
    
}
