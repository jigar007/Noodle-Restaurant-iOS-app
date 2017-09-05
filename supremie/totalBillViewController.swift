//
//  totalBillViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class totalBillViewController: UIViewController
//    , UITableViewDataSource,UITableViewDelegate
 {
    
    @IBAction func cash(_ sender: Any) {
        showAlert(message: "cash")
    }
    
    @IBAction func card(_ sender: Any) {
        showAlert(message: "card")
    }
    
    @IBOutlet weak var fianlTotalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Button and title in navigation bar
        self.title = "Review Pesanan"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 19, height: 49)
        btnLeftMenu.addTarget(self, action: #selector(totalBillViewController.onClcikBack), for: UIControlEvents.touchUpInside)
        
        btnLeftMenu.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        
//        
//    }
//
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//    }
//    
}


extension totalBillViewController {
    
    func showAlert(message:String)  {
        
        let alertController = UIAlertController(title: "Warning!", message: "Are you sure want to pay by " + message, preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.createRequestrDict(paymentType: message)
        }
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionOk)
        
        present(alertController, animated: true, completion: nil)
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
                guard let data = data, error == nil else {                                                                     print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {                               print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
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
