//
//  FirstViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://139.59.96.68:8000/stock")
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {

                let json = try JSONSerialization.jsonObject(with: data)as? [String:Any]
                InfoDetail.sharedInstant.objItem = Mie(fromDictionary: json!)
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
 
    // MARK: for hidding navigation bar in first screen
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Button actions
    @IBAction func quickOrder(_ sender: Any) {
        
        performSegue(withIdentifier: "firstToSecond", sender: self)
        InfoDetail.sharedInstant.JSONItem.diningMethod = "makan disini"
    }
    
    @IBAction func takeAway(_ sender: Any) {
        
        performSegue(withIdentifier: "firstToSecond", sender: self)
        InfoDetail.sharedInstant.JSONItem.diningMethod = "bungkus"
    }

}
