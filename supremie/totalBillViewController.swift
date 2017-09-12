//
//  totalBillViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class totalBillViewController: UIViewController, UITableViewDataSource,UITableViewDelegate
{
    var finalTotalPrice: Int = 0
    static var orderNumber:Int = 0
    
    var tableData:[SuperOfAll] = [SuperOfAll]()
    let formatter = NumberFormatter()
    
    
    let tempItem = InfoDetail.sharedInstant.objItem.mie.filter({ (drink) -> Bool in
        if drink.count > 0 {
            return true
        }
        return false
    }).first

    @IBOutlet weak var serviceCharge: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalSum: UILabel!
    @IBAction func cash(_ sender: Any) {
        self.createRequestrDict(paymentType: "cash" )
    }
    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var tax: UILabel!
    
    @IBAction func card(_ sender: Any) {
        self.createRequestrDict(paymentType: "card" )
    }
    
    @IBOutlet weak var fianlTotalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "DE")
        
        
        let obj:SuperOfAll = SuperOfAll()
        
        obj.name = (tempItem?.brand)!+" "+(tempItem?.flavour!)!
        obj.qty = (tempItem?.count)!
        obj.price = Int((tempItem?.price!)!) * Int((tempItem?.count)!)
        
        tableData.append(obj)
        
        for topping in SelectedModel.sharedInstant.selectedToppings {
            let obj:SuperOfAll = SuperOfAll()
            obj.name = topping.name
            obj.price = topping.price * topping.count
            obj.qty=topping.count
            tableData.append(obj)
            
        }
        for drink in SelectedModel.sharedInstant.selectedDrinks {
            let obj:SuperOfAll = SuperOfAll()
            obj.name = drink.brand+" "+drink.flavour
            obj.price=drink.price * drink.count
            obj.qty=drink.count
            tableData.append(obj)
        }
        let chilliobj:SuperOfAll = SuperOfAll()
        chilliobj.name = "Level Pedas " + String(SelectedModel.sharedInstant.chilliLevel)
        chilliobj.qty = 1
        chilliobj.price = SelectedModel.sharedInstant.chilliPrice
        tableData.append(chilliobj)
        
        var sum:Int = 0
        for each in tableData
        {
            sum = sum + each.price
        }
        sum = sum + SelectedModel.sharedInstant.chilliPrice
        
        let serviceCharge:Int = (sum * 5)/100
        self.serviceCharge.text = currencyFormat(currency: serviceCharge)
        
        
        let Tax:Int = (sum * 10)/100
        finalTotalPrice = Tax + sum
        self.tax.text = currencyFormat(currency:Tax)
        self.totalSum.text = currencyFormat(currency:sum)
        self.fianlTotalPrice.text = currencyFormat(currency:finalTotalPrice)
        
        // For Button and title in navigation bar
        self.title = "REVIEW PESANAN"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "< Kembali", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClcikBack))
        navigationItem.leftBarButtonItem = backButton
        
    }
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            tableData.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"billCell", for: indexPath) as!billTableViewCell
        
        cell.iteamName.text = tableData[indexPath.row].name
        cell.Qty.text = "Qty "+String(tableData[indexPath.row].qty)
        cell.price.text = currencyFormat(currency: tableData[indexPath.row].price)
        return cell
        
    }
    
    
    func createRequestrDict(paymentType:String)  {
        
        var requestDict = [String : Any]()
        var orderDict = [String : Any]()
        orderDict["total_price"] = calculateTotalPrice()
        orderDict["payment_method"] = paymentType
        orderDict["dining_method"] = SelectedModel.sharedInstant.dining_method
        
        var mieDict = [String:Any]()
        mieDict["id"] = (tempItem?.id)!
        mieDict["quantity_mie"] = (tempItem?.count)!
        mieDict["quantity_whole"] = "0" // Do not touch
        mieDict["price"] = SelectedModel.sharedInstant.selectedMie?.price
        mieDict["extra_chili"] = SelectedModel.sharedInstant.chilliLevel
        mieDict["note"]=""
        
        var toppingList = [[String:Any]]()
        for topping in SelectedModel.sharedInstant.selectedToppings {
            var toppingDict = [String:Any]()
            toppingDict["id"] = topping.id
            toppingDict["quantity"] = topping.count
            toppingDict["price"] = topping.price
            toppingList.append(toppingDict)
        }
        
        mieDict["toppings"] = toppingList
        orderDict["mies"] = [mieDict]
        
        var drinkList = [[String:Any]]()
        for drink in SelectedModel.sharedInstant.selectedDrinks {
            var drinkDict = [String:Any]()
            drinkDict["id"] = drink.id
            drinkDict["quantity"] = drink.count
            drinkDict["price"] = drink.price
            drinkList.append(drinkDict)
        }
        orderDict["drinks"] = drinkList
        requestDict["order"] = orderDict
        requestToPay(params: requestDict)
    }
    
    func calculateTotalPrice() -> Int {
        
        let tempItem = InfoDetail.sharedInstant.objItem.mie.filter({ (drink) -> Bool in
            if drink.count > 0 {
                return true
            }
            return false
        }).first
        
        var totalAmount:Int = Int((tempItem?.price!)!) * Int((tempItem?.count)!) + SelectedModel.sharedInstant.chilliPrice
        
        for drinks in  SelectedModel.sharedInstant.selectedDrinks {
            totalAmount = totalAmount + (drinks.price * drinks.count)
        }
        
        for toppings in SelectedModel.sharedInstant.selectedToppings {
            totalAmount = totalAmount + (toppings.price * toppings.count)
        }
        let withTax:Int = (totalAmount * 15)/100
        
        return withTax + totalAmount
    }

    func requestToPay(params:[String:Any]) {
        
        var request = URLRequest(url: URL(string: "http://139.59.96.68:8000/orders/")!)
        request.httpMethod = "POST"
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            let jsonString = String(data: bodyData, encoding: String.Encoding.utf8)
            print(jsonString!)
            
            request.httpBody = bodyData
            request.setValue("application/json;application/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {                               print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                } else {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)as? [String:Any]
                        totalBillViewController.orderNumber = (json?["id"] as? Int)!
                        print(totalBillViewController.orderNumber )
                    }catch{
                    }
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(String(describing: responseString))")
                }                
            }
            task.resume()
            
        } catch  {
            print(error)
        }
    }
}
