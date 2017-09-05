//
//	Topping.swift
//
//	Create by Jigar Thakkar on 4/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Topping : NSObject, NSCoding{

	var id : Int!
	var price : Int!
	var quantity : Int!
	var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		price = dictionary["price"] as? Int
		quantity = dictionary["quantity"] as? Int
		type = dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if price != nil{
			dictionary["price"] = price
		}
		if quantity != nil{
			dictionary["quantity"] = quantity
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         price = aDecoder.decodeObject(forKey: "price") as? Int
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}