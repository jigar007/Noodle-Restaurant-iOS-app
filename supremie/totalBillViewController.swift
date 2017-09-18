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

    @IBOutlet weak var serviceCharge: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalSum: UILabel!
    @IBAction func cash(_ sender: Any) {
        self.createRequestrDict(paymentType: "cash" )
    }
    @IBAction func card(_ sender: Any) {
        self.createRequestrDict(paymentType: "card" )
    }

    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var tax: UILabel!
    
    
    let tempItem = InfoDetail.sharedInstant.objItem.mie.filter({ (drink) -> Bool in
        if drink.count > 0 {
            return true
        }
        return false
    }).first
    
    
    @IBOutlet weak var fianlTotalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate SuperofAll
        let obj:SuperOfAll = SuperOfAll()
        obj.id = (tempItem?.id)!
        obj.type = "mie"
        obj.name = (tempItem?.brand)!+" "+(tempItem?.flavour!)!
        obj.qty = (tempItem?.count)!
        obj.price = Int((tempItem?.price!)!)
        
        tableData.append(obj)
        
        for topping in SelectedModel.sharedInstant.selectedToppings {
            let obj:SuperOfAll = SuperOfAll()
            obj.id = topping.id
            obj.type = "toppings"
            obj.name = topping.name
            obj.price = topping.price
            obj.qty=topping.count
            tableData.append(obj)
            
        }
        for drink in SelectedModel.sharedInstant.selectedDrinks {
            let obj:SuperOfAll = SuperOfAll()
            obj.id =  drink.id
            obj.type = "drinks"
            obj.name = drink.brand+" "+drink.flavour
            obj.price=drink.price
            obj.qty=drink.count
            tableData.append(obj)
        }
        let chilliobj:SuperOfAll = SuperOfAll()
        chilliobj.name = "Level Pedas " + String(SelectedModel.sharedInstant.chilliLevel)
        chilliobj.qty = 1
        chilliobj.price = SelectedModel.sharedInstant.chilliPrice
        chilliobj.type = "chilli"
        chilliobj.chilliLevel = SelectedModel.sharedInstant.chilliLevel
        tableData.append(chilliobj)
        
        // For Button and title in navigation bar
        navigationBar(title: "REVIEW PESANAN")
        populateTableData()
        
    }
    
    func populateTableData(){
        
        var sum:Int = 0
        for each in tableData
        {
            sum = sum + (each.price * each.qty)
        }
        self.totalSum.text = currencyFormat(currency:sum)

        let serviceCharge:Int = (sum * 5)/100
        self.serviceCharge.text = currencyFormat(currency: serviceCharge)
        
        let Tax:Int = (sum * 10)/100
        self.tax.text = currencyFormat(currency:Tax)
        
        finalTotalPrice = Tax + sum
        self.fianlTotalPrice.text = currencyFormat(currency:finalTotalPrice)
    }
    
    override func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"billCell", for: indexPath) as!billTableViewCell
        
        cell.iteamName.text = tableData[indexPath.row].name
        cell.Qty.text = "Qty "+String(tableData[indexPath.row].qty)
        cell.price.text = currencyFormat(currency: tableData[indexPath.row].price * tableData[indexPath.row].qty)
        
        cell.tag = indexPath.row
        
        if indexPath.row == 0 {
            cell.cancelBtn.isHidden = true
        }
        
        cell.clickComplition = { index in
            self.whenRowEdited(index: index)
        }
        
        return cell
    }
    func whenRowEdited(index: Int){
        tableData.remove(at: index)
        populateTableData()
        table.reloadData()
    }
    
    func createRequestrDict(paymentType:String)  {
        
        var requestDict = [String : Any]()
        var orderDict = [String : Any]()
        orderDict["total_price"] = finalTotalPrice
        orderDict["payment_method"] = paymentType
        orderDict["dining_method"] = SelectedModel.sharedInstant.dining_method
        
        var mieDict = [String:Any]()
        var toppingList = [[String:Any]]()
        var drinkList = [[String:Any]]()
        mieDict["extra_chili"] = 0
        mieDict["quantity_whole"] = "0" // Do not touch
        mieDict["note"]=""
        
        for obj in tableData {
            if obj.type == "toppings"{
                var toppingDict = [String:Any]()
                toppingDict["id"] = obj.id
                toppingDict["quantity"] = obj.qty
                toppingDict["price"] = obj.price
                toppingList.append(toppingDict)
            } else if obj.type == "drinks"{
                var drinkDict = [String:Any]()
                drinkDict["id"] = obj.id
                drinkDict["quantity"] = obj.qty
                drinkDict["price"] = obj.price
                drinkList.append(drinkDict)
            } else if obj.type == "mie" {
                mieDict["id"] = obj.id
                mieDict["quantity_mie"] = obj.qty
                mieDict["price"] = obj.price
            } else if obj.type == "chilli" {
                mieDict["extra_chili"] = obj.chilliLevel
            }
        }
        
        mieDict["toppings"] = toppingList
        orderDict["drinks"] = drinkList
        orderDict["mies"] = [mieDict]
        requestDict["order"] = orderDict
        requestToPay(params: requestDict)
    }
    
    func requestToPay(params:[String:Any]) {
        
        var request = URLRequest(url: URL(string: "http://192.168.0.100:80/orders")!)
//        var request = URLRequest(url: URL(string: "http://139.59.96.68:8000/orders")!)
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
