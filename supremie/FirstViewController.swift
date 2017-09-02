//
//  FirstViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {


    
//    override func viewDidAppear(){
//        self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0)
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://139.59.96.68:8000/stock")
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {

                let json = try JSONSerialization.jsonObject(with: data)as? [String:Any]
                print(json!)
                
                
                let mie = json?["mie"] as? [[String: Any]] ?? []
                print(mie)
                
                
//                let toppings = json["toppings"] as? [[String: Any]] ?? []
//                let drinks = json["drinks"] as? [[String: Any]] ?? []
//                
//                let dict=[]
//                
//                for each in mie{
//                    dict.append(each)
//                }
//                print(dict)
//                for each in mie[0]{
//                    print(each)}
//                
//                UserDefaults.standard.set(mie, forKey: "mie")
                
                
            } catch let error as NSError {
                print(error)

                
            }
        }).resume()
        
//        let arr = UserDefaults.standard.string(forKey: "json")
//        print(arr!)

    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
    }
    
    @IBAction func takeAway(_ sender: Any) {
        
        performSegue(withIdentifier: "firstToSecond", sender: self)
        
    }

}
