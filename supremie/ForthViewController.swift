//
//  ForthViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var toppingsButton: UIButton!
    
    var toppingList = InfoDetail.sharedInstant.objItem.toppings.filter { (topping) -> Bool in
        return topping.stock >= 3
    }
    
    @IBOutlet weak var toppingsCollectionView: UICollectionView!
    
    @IBAction func toppingSelect(_ sender: Any) {
        SelectedModel.sharedInstant.selectedToppings = toppingList.filter({ (topping) -> Bool in
            return topping.count > 0
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Button and title in navigation bar
        navigationBar(title: "PILIH TOPPING")
        
        // For making collection view device independent
        var screenSize: CGRect!
        var screenWidth: CGFloat!
        var screenHeight: CGFloat!
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 8, right: 4)
        layout.itemSize = CGSize(width: (screenWidth/3)-8, height: (screenHeight/3)-40)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        toppingsCollectionView.collectionViewLayout = layout
        toppingsButton.isUserInteractionEnabled = false
    }
    
    
    override func onClcikBack() {
        SelectedModel.sharedInstant.selectedToppings = [Topping]()
        InfoDetail.sharedInstant.objItem.toppings = InfoDetail.sharedInstant.objItem.toppings.map({ (object) -> Topping in
            object.count = 0
            return object
        })
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return toppingList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"toppingsCell", for: indexPath) as! toppingsCollectionViewCell
        
        cell.objTopping = toppingList[indexPath.row]
        cell.tag = indexPath.row
        cell.toppingPrice.text = currencyFormat(currency: toppingList[indexPath.row].price)
        
        cell.clickComplition = { (count, index) in
            if (count == 0){
                self.toppingsButton.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
            }else{
                self.toppingsButton.backgroundColor = UIColor(red: 227/255, green: 41/255, blue: 48/255, alpha: 1.0)
            }
            self.enableDisbleButton()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? toppingsCollectionViewCell
        cell?.increnmentValue()
    }
    
    func enableDisbleButton()  {
        let tempList = toppingList.filter { (topping) -> Bool in
            return topping.count > 0
        }
        guard tempList.count > 0 else {
            toppingsButton.isUserInteractionEnabled = false
            return
        }
        toppingsButton.isUserInteractionEnabled = true
    }
}
