//
//	Drink.swift
//
//	Create by Aman Prajapati on 2/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Drink : NSObject, NSCoding{

	var brand : String!
	var flavour : String!
	var id : Int!
	var imgUrl : String!
	var price : Int!
	var stock : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		brand = dictionary["brand"] as? String
		flavour = dictionary["flavour"] as? String
		id = dictionary["id"] as? Int
		imgUrl = dictionary["img_url"] as? String
		price = dictionary["price"] as? Int
		stock = dictionary["stock"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if brand != nil{
			dictionary["brand"] = brand
		}
		if flavour != nil{
			dictionary["flavour"] = flavour
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imgUrl != nil{
			dictionary["img_url"] = imgUrl
		}
		if price != nil{
			dictionary["price"] = price
		}
		if stock != nil{
			dictionary["stock"] = stock
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         brand = aDecoder.decodeObject(forKey: "brand") as? String
         flavour = aDecoder.decodeObject(forKey: "flavour") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imgUrl = aDecoder.decodeObject(forKey: "img_url") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         stock = aDecoder.decodeObject(forKey: "stock") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if brand != nil{
			aCoder.encode(brand, forKey: "brand")
		}
		if flavour != nil{
			aCoder.encode(flavour, forKey: "flavour")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if imgUrl != nil{
			aCoder.encode(imgUrl, forKey: "img_url")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if stock != nil{
			aCoder.encode(stock, forKey: "stock")
		}

	}

}