//
//	Mie.swift
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.

import Foundation

class Mie : NSObject, NSCoding{

	var drinks : [Drink]!
	var mie : [Drink]!
	var toppings : [Topping]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		drinks = [Drink]()
		if let drinksArray = dictionary["drinks"] as? [[String:Any]]{
			for dic in drinksArray{
				let value = Drink(fromDictionary: dic)
				drinks.append(value)
			}
		}
		mie = [Drink]()
		if let mieArray = dictionary["mie"] as? [[String:Any]]{
			for dic in mieArray{
				let value = Drink(fromDictionary: dic)
				mie.append(value)
			}
		}
		toppings = [Topping]()
		if let toppingsArray = dictionary["toppings"] as? [[String:Any]]{
			for dic in toppingsArray{
				let value = Topping(fromDictionary: dic)
				toppings.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if drinks != nil{
			var dictionaryElements = [[String:Any]]()
			for drinksElement in drinks {
				dictionaryElements.append(drinksElement.toDictionary())
			}
			dictionary["drinks"] = dictionaryElements
		}
		if mie != nil{
			var dictionaryElements = [[String:Any]]()
			for mieElement in mie {
				dictionaryElements.append(mieElement.toDictionary())
			}
			dictionary["mie"] = dictionaryElements
		}
		if toppings != nil{
			var dictionaryElements = [[String:Any]]()
			for toppingsElement in toppings {
				dictionaryElements.append(toppingsElement.toDictionary())
			}
			dictionary["toppings"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         drinks = aDecoder.decodeObject(forKey :"drinks") as? [Drink]
         mie = aDecoder.decodeObject(forKey :"mie") as? [Drink]
         toppings = aDecoder.decodeObject(forKey :"toppings") as? [Topping]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if drinks != nil{
			aCoder.encode(drinks, forKey: "drinks")
		}
		if mie != nil{
			aCoder.encode(mie, forKey: "mie")
		}
		if toppings != nil{
			aCoder.encode(toppings, forKey: "toppings")
		}

	}

}
