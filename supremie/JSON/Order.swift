//
//	Order.swift
//
//	Create by Jigar Thakkar on 4/9/2017
//	Copyright © 2017. All rights reserved.

import Foundation


class Order : NSObject, NSCoding{

	var diningMethod : String!
	var drinks : [JSONDrink]!
	var mies : [My]!
	var paymentMethod : String!
	var totalPrice : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		diningMethod = dictionary["dining_method"] as? String
		drinks = [JSONDrink]()
		if let drinksArray = dictionary["drinks"] as? [[String:Any]]{
			for dic in drinksArray{
				let value = JSONDrink(fromDictionary: dic)
				drinks.append(value)
			}
		}
		mies = [My]()
		if let miesArray = dictionary["mies"] as? [[String:Any]]{
			for dic in miesArray{
				let value = My(fromDictionary: dic)
				mies.append(value)
			}
		}
		paymentMethod = dictionary["payment_method"] as? String
		totalPrice = dictionary["total_price"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if diningMethod != nil{
			dictionary["dining_method"] = diningMethod
		}
		if drinks != nil{
			var dictionaryElements = [[String:Any]]()
			for drinksElement in drinks {
				dictionaryElements.append(drinksElement.toDictionary())
			}
			dictionary["drinks"] = dictionaryElements
		}
		if mies != nil{
			var dictionaryElements = [[String:Any]]()
			for miesElement in mies {
				dictionaryElements.append(miesElement.toDictionary())
			}
			dictionary["mies"] = dictionaryElements
		}
		if paymentMethod != nil{
			dictionary["payment_method"] = paymentMethod
		}
		if totalPrice != nil{
			dictionary["total_price"] = totalPrice
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         diningMethod = aDecoder.decodeObject(forKey: "dining_method") as? String
         drinks = aDecoder.decodeObject(forKey :"drinks") as? [JSONDrink]
         mies = aDecoder.decodeObject(forKey :"mies") as? [My]
         paymentMethod = aDecoder.decodeObject(forKey: "payment_method") as? String
         totalPrice = aDecoder.decodeObject(forKey: "total_price") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if diningMethod != nil{
			aCoder.encode(diningMethod, forKey: "dining_method")
		}
		if drinks != nil{
			aCoder.encode(drinks, forKey: "drinks")
		}
		if mies != nil{
			aCoder.encode(mies, forKey: "mies")
		}
		if paymentMethod != nil{
			aCoder.encode(paymentMethod, forKey: "payment_method")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "total_price")
		}

	}

}
