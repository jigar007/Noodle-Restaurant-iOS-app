//
//  SingletoneHandler.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.


import Foundation

class InfoDetail {
    
    static let sharedInstant:InfoDetail = InfoDetail()
    var objItem:Mie!
    var JSONItem:Order!
    
    static var selectedName:String = ""
    
    static var dining_method:String = ""
    static var id: Int = 0
    static var quantity_mie:Int = 0
    static var price:Int = 0
    
    
}
