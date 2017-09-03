//
//	POST.swift
//
//	Create by Jigar Thakkar on 4/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class POST : NSObject, NSCoding{

	var order : Order!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let orderData = dictionary["order"] as? [String:Any]{
			order = Order(fromDictionary: orderData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if order != nil{
			dictionary["order"] = order.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         order = aDecoder.decodeObject(forKey: "order") as? Order

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if order != nil{
			aCoder.encode(order, forKey: "order")
		}

	}

}