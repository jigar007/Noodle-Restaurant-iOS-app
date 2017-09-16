//
//  FirstViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var btnMakan: UIButton!
    @IBOutlet weak var btnBungkus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "Kembali", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        UINavigationBar.appearance().tintColor = UIColor.white
        
        let url = URL(string: "http://192.168.0.100:80/stock")
        disableButton()
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {

                let json = try JSONSerialization.jsonObject(with: data)as? [String:Any]
                InfoDetail.sharedInstant.objItem = Mie(fromDictionary: json!)
                self.enableButton()
                
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
        SelectedModel.sharedInstant.dining_method = "makan sini"
    }
    
    @IBAction func takeAway(_ sender: Any) {
        
        performSegue(withIdentifier: "firstToSecond", sender: self)
        SelectedModel.sharedInstant.dining_method = "bungkus"
    }

    private func enableButton() {
        btnMakan.isUserInteractionEnabled = true
        btnBungkus.isUserInteractionEnabled = true
    }
    
    private func disableButton() {
        btnMakan.isUserInteractionEnabled = false
        btnBungkus.isUserInteractionEnabled = false
    }
   
}
