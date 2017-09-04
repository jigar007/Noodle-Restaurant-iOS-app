//
//  ForthViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
 
    var toppingsList = [String]()
    var toppingDictionary = [Int: Int]()
//    var selectedIndexPath:Int = 0
//    var selectedCount:Int = 0
    var selectedToppingList = [JSONTopping]()
 
    @IBOutlet weak var toppingsCollectionView: UICollectionView!
    
    @IBAction func toppingSelect(_ sender: Any) {
       
        for (index,count) in toppingDictionary{
            for item in InfoDetail.sharedInstant.objItem.toppings
            {
                if item.id == index {
//                    let toppingItem : JSONTopping
//                    toppingItem.id = item.id
//                    toppingItem.price = item.price
//                    toppingItem.quantity = count
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in InfoDetail.sharedInstant.objItem.toppings
        {
            if item.stock>3 {
                toppingsList.append(item.name)
                
            }
        }
        
        // For Button and title in navigation bar
        self.title = "Pilih Topping"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 19, height: 49)
        btnLeftMenu.addTarget(self, action: #selector(ForthViewController.onClcikBack), for: UIControlEvents.touchUpInside)
        
        btnLeftMenu.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
        // For making collection view device independent
        var screenSize: CGRect!
        var screenWidth: CGFloat!
        var screenHeight: CGFloat!
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 8, right: 4)
        layout.itemSize = CGSize(width: (screenWidth/2)-8, height: (screenHeight/3)-40)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        toppingsCollectionView.collectionViewLayout = layout
        
    }
    
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
        
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return toppingsList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"toppingsCell", for: indexPath) as! toppingsCollectionViewCell
        
        cell.toppingsPicture.image = UIImage(named: toppingsList[indexPath.row])
        
        if ((UIImage(named: toppingsList[indexPath.row])) != nil){
            cell.toppingsPicture.image = UIImage(named: toppingsList[indexPath.row])
        }else{
            cell.toppingsPicture.image = UIImage(named: "Default")
        }
        
        cell.toppingsName.text =  toppingsList[indexPath.row]
        
        cell.tag = indexPath.row
        cell.clickComplition = { (count, index) in
            
            self.toppingDictionary[index+1] = count
//            for item in InfoDetail.sharedInstant.objItem.toppings
//            {
//                if item.id == index + 1{
//                    var toppingItem : JSONTopping
//                    toppingItem.id = item.id
//                    toppingItem.price = item.price
//                    toppingItem.quantity = count
//                }
//            }
        }
        return cell
    }
}
