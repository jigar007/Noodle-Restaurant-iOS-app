//
//	My.swift
//
//	Create by Jigar Thakkar on 4/9/2017
//	Copyright © 2017. All rights reserved.

import Foundation


class My : NSObject, NSCoding{

	var extraChili : Int!
	var id : Int!
	var note : String!
	var price : Int!
	var quantityMie : Int!
	var quantityWhole : Int!
	var toppings : [JSONTopping]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		extraChili = dictionary["extra_chili"] as? Int
		id = dictionary["id"] as? Int
		note = dictionary["note"] as? String
		price = dictionary["price"] as? Int
		quantityMie = dictionary["quantity_mie"] as? Int
		quantityWhole = dictionary["quantity_whole"] as? Int
		toppings = [JSONTopping]()
		if let toppingsArray = dictionary["toppings"] as? [[String:Any]]{
			for dic in toppingsArray{
				let value = JSONTopping(fromDictionary: dic)
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
		if extraChili != nil{
			dictionary["extra_chili"] = extraChili
		}
		if id != nil{
			dictionary["id"] = id
		}
		if note != nil{
			dictionary["note"] = note
		}
		if price != nil{
			dictionary["price"] = price
		}
		if quantityMie != nil{
			dictionary["quantity_mie"] = quantityMie
		}
		if quantityWhole != nil{
			dictionary["quantity_whole"] = quantityWhole
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
         extraChili = aDecoder.decodeObject(forKey: "extra_chili") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         note = aDecoder.decodeObject(forKey: "note") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         quantityMie = aDecoder.decodeObject(forKey: "quantity_mie") as? Int
         quantityWhole = aDecoder.decodeObject(forKey: "quantity_whole") as? Int
         toppings = aDecoder.decodeObject(forKey :"toppings") as? [JSONTopping]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if extraChili != nil{
			aCoder.encode(extraChili, forKey: "extra_chili")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if note != nil{
			aCoder.encode(note, forKey: "note")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if quantityMie != nil{
			aCoder.encode(quantityMie, forKey: "quantity_mie")
		}
		if quantityWhole != nil{
			aCoder.encode(quantityWhole, forKey: "quantity_whole")
		}
		if toppings != nil{
			aCoder.encode(toppings, forKey: "toppings")
		}

	}

}
