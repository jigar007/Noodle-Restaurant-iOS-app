//
//  drinksViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class drinksViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var drinksButton: UIButton!
    var drinksList = InfoDetail.sharedInstant.objItem.drinks

    @IBOutlet weak var drinksCiewController: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // For Button and title in navigation bar
        navigationBar(title:"PILIH MINUMAN")

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
        drinksCiewController.collectionViewLayout = layout
        drinksButton.isUserInteractionEnabled = false
    }
    
    override func onClcikBack() {
        InfoDetail.sharedInstant.objItem.drinks = InfoDetail.sharedInstant.objItem.drinks.map({ (object) -> Drink in
            object.count = 0
            return object
        })
        SelectedModel.sharedInstant.selectedDrinks = [Drink]()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return drinksList!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"drinksCell", for: indexPath) as! drinksCollectionViewCell
        
        cell.objDrinks = drinksList?[indexPath.row]
        cell.drinksPrice.text = currencyFormat(currency: (drinksList?[indexPath.row].price)!)
        cell.tag = indexPath.row
        cell.clickComplition = { (count, index) in
            
            if (count == 0){
                self.drinksButton.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
            }else{
                self.drinksButton.backgroundColor = UIColor(red: 227/255, green: 41/255, blue: 48/255, alpha: 1.0)
            }
            self.enableDisableNextButton()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? drinksCollectionViewCell
        cell?.increnmentValue()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drinksToBills" {
            SelectedModel.sharedInstant.selectedDrinks = (drinksList?.filter({ (drink) -> Bool in
                return drink.count > 0
            }))!
        }
    }

    func enableDisableNextButton()  {
        let tempList = drinksList?.filter { (drink) -> Bool in
            return drink.count > 0
        }
        
        guard (tempList?.count)! > 0 else {
            drinksButton.isUserInteractionEnabled = false
            drinksButton.backgroundColor = UIColor.gray
            return
        }
        drinksButton.backgroundColor = UIColor.red
        drinksButton.isUserInteractionEnabled = true
    }
}
