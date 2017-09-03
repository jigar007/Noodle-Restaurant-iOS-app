/*
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Order {
	public var total_price : Int?
	public var payment_method : String?
	public var dining_method : String?
	public var mies : Array<Mies>?
	public var drinks : Array<Drinks>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let order_list = Order.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Order Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Order]
    {
        var models:[Order] = []
        for item in array
        {
            models.append(Order(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let order = Order(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Order Instance.
*/
	required public init?(dictionary: NSDictionary) {

		total_price = dictionary["total_price"] as? Int
		payment_method = dictionary["payment_method"] as? String
		dining_method = dictionary["dining_method"] as? String
		if (dictionary["mies"] != nil) { mies = Mies.modelsFromDictionaryArray(array: dictionary["mies"] as! NSArray) }
		if (dictionary["drinks"] != nil) { drinks = Drinks.modelsFromDictionaryArray(array: dictionary["drinks"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.total_price, forKey: "total_price")
		dictionary.setValue(self.payment_method, forKey: "payment_method")
		dictionary.setValue(self.dining_method, forKey: "dining_method")

		return dictionary
	}

}
