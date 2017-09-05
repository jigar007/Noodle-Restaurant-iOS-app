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
    
    static var selectedName:String = ""
    
    static var id: Int = 0
    static var quantity_mie:Int = 0
    static var price:Int = 0
    
}

class SelectedModel {
    static let sharedInstant: SelectedModel = SelectedModel()
    
    var selectedMie: Drink?
    var selectedToppings = [Topping]()
    
    var selectedDrinks = [Drink]()
    var dining_method:String = ""
    
    var chilliLevel = 0
    
}
