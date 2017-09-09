//
//  thankYouViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class thankYouViewController: UIViewController {
    
    var isPresent = true
    
    @IBOutlet weak var orderID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        orderID.text = "Order ID:"+String(totalBillViewController.orderNumber)
        createTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
        isPresent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func btnDoneClick(_ sender: Any) {
        navigateToMainViewController()
    }
    
    private func navigateToMainViewController() {
        emptyObject()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func emptyObject() {
        
        InfoDetail.sharedInstant.objItem.drinks = InfoDetail.sharedInstant.objItem.drinks.map { (object) -> Drink in
            object.count = 0
            return object
        }
        InfoDetail.sharedInstant.objItem.toppings = InfoDetail.sharedInstant.objItem.toppings.map { (object) -> Topping in
            object.count = 0
            return object
        }
        
        InfoDetail.sharedInstant.objItem.mie = InfoDetail.sharedInstant.objItem.mie.map { (object) -> Drink in
            object.count = 0
            return object
        }
        SelectedModel.sharedInstant.selectedDrinks = [Drink]()
        SelectedModel.sharedInstant.selectedToppings = [Topping]()
        SelectedModel.sharedInstant.selectedMie = nil
    }
    
    @objc private func performNavigationBackAfterSomeTime() {
        guard isPresent else {
            return
        }
        
        navigateToMainViewController()
    }
    
    private func createTimer() {
        perform(#selector(performNavigationBackAfterSomeTime), with: nil, afterDelay: 10)
    }
}
