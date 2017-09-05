//
//  thankYouViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class thankYouViewController: UIViewController {
    
    @IBOutlet weak var orderID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderID.text = "Order ID:"+String(totalBillViewController.orderNumber)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
