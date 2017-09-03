//
//	Topping.swift
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.

import Foundation


class Topping : NSObject, NSCoding{

	var id : Int!
	var imgUrl : String!
	var name : String!
	var price : Int!
	var stock : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		imgUrl = dictionary["img_url"] as? String
		name = dictionary["name"] as? String
		price = dictionary["price"] as? Int
		stock = dictionary["stock"] as? Int
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
		if imgUrl != nil{
			dictionary["img_url"] = imgUrl
		}
		if name != nil{
			dictionary["name"] = name
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imgUrl = aDecoder.decodeObject(forKey: "img_url") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         stock = aDecoder.decodeObject(forKey: "stock") as? Int

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
		if imgUrl != nil{
			aCoder.encode(imgUrl, forKey: "img_url")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if stock != nil{
			aCoder.encode(stock, forKey: "stock")
		}

	}

}
