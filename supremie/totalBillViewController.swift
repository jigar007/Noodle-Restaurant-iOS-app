//
//  totalBillViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class totalBillViewController: UIViewController {
//, UITableViewDataSource,UITableViewDelegate
    @IBAction func cash(_ sender: Any) {
        
        var request = URLRequest(url: URL(string: "http://www.thisismylink.com/postName.php")!)
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    @IBAction func card(_ sender: Any) {
    }
    
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
//        return 12
//    }
//    
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier:"billCell", for: indexPath) as! billTableViewCell
//        return cell
//    }
}
