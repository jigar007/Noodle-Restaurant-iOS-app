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
    
    // Currency formatter
    let formatter = NumberFormatter()
 

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

        if (table.contentSize.height < table.frame.size.height) {
            table.isScrollEnabled = false
        }
        else {
            table.isScrollEnabled = true
        }
        
        let obj:SuperOfAll = SuperOfAll()
        obj.name = (SelectedModel.sharedInstant.selectedMie?.flavour)!
        obj.qty = (SelectedModel.sharedInstant.selectedMie?.count)!
        obj.price = (SelectedModel.sharedInstant.selectedMie?.price)!
        
        tableData.append(obj)

        for topping in SelectedModel.sharedInstant.selectedToppings {
            let obj:SuperOfAll = SuperOfAll()
            obj.name=topping.name
            obj.price=topping.price
            obj.qty=topping.count
            tableData.append(obj)
            
        }
        for drink in SelectedModel.sharedInstant.selectedDrinks {
            let obj:SuperOfAll = SuperOfAll()
            obj.name = drink.brand+" "+drink.flavour
            obj.price=drink.price
            obj.qty=drink.count
            tableData.append(obj)
        }
        var sum:Int = 0
        for each in tableData
        {
            sum = sum + each.price
        }
        
        let Tax:Int = (sum * 15)/100
        
        finalTotalPrice = Tax + sum
        self.tax.text = "RP "+String(describing: formatter.string(from: Tax as NSNumber)!)
        self.totalSum.text = "RP "+String(describing: formatter.string(from: sum as NSNumber)!)
        self.fianlTotalPrice.text = "RP "+String(describing: formatter.string(from: finalTotalPrice as NSNumber)!)

        
        
        // For Button and title in navigation bar
        self.title = "Review Pesanan"
        
        let backButton = UIBarButtonItem(title: "Kembali", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        
    }
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
        
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"billCell", for: indexPath) as!billTableViewCell
        
        cell.iteamName.text = tableData[indexPath.row].name
        cell.Qty.text = "Qty "+String(tableData[indexPath.row].qty)
        cell.price.text = "RP "+String(describing: formatter.string(from: tableData[indexPath.row].price as NSNumber)!)

        return cell

    }

  
    func createRequestrDict(paymentType:String)  {
        
        var requestDict = [String : Any]()
        var orderDict = [String : Any]()
        orderDict["total_price"] = calculateTotalPrice()
        orderDict["payment_method"] = paymentType
        orderDict["dining_method"] = SelectedModel.sharedInstant.dining_method
        
        var mieDict = [String:Any]()
        mieDict["id"] = SelectedModel.sharedInstant.selectedMie?.id
        mieDict["quantity_mie"] = SelectedModel.sharedInstant.selectedMie?.count
        mieDict["quantity_whole"] = SelectedModel.sharedInstant.selectedMie?.count
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
        
        var totalAmount:Int = (SelectedModel.sharedInstant.selectedMie?.price)!
        
        for drinks in  SelectedModel.sharedInstant.selectedDrinks {
            totalAmount = totalAmount + drinks.price
        }
        
        for toppings in SelectedModel.sharedInstant.selectedToppings {
            totalAmount = totalAmount + toppings.price
        }
        return totalAmount
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
                }
                
                do{
                let json = try JSONSerialization.jsonObject(with: data)as? [String:Any]
                totalBillViewController.orderNumber = (json?["id"] as? Int)!
                    print(totalBillViewController.orderNumber )
                }catch{
                }
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
            
        } catch  {
            print(error)
        }
    }
}
