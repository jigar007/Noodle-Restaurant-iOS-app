//
//  drinksViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class drinksViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {

    var drinksList = [String]()
    var selectedIndexPath:Int = 0
    var selectedCount:Int = 0
    
    @IBOutlet weak var drinksCiewController: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in InfoDetail.sharedInstant.objItem.drinks
        {
            if item.stock>0 {
                drinksList.append(item.brand+" "+item.flavour)
            }
        }
        print(drinksList)
        
        // For Button and title in navigation bar
        self.title = "Pilih Minuman & ES"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 19, height: 49)
        btnLeftMenu.addTarget(self, action: #selector(drinksViewController.onClcikBack), for: UIControlEvents.touchUpInside)
        
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
        drinksCiewController.collectionViewLayout = layout
        
    }
    
    
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return drinksList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"drinksCell", for: indexPath) as! drinksCollectionViewCell
        
        if ((UIImage(named: drinksList[indexPath.row])) != nil){
            cell.drinksPicture.image = UIImage(named: drinksList[indexPath.row])
        }else{
            cell.drinksPicture.image = UIImage(named: "Default")
        }
        
        cell.drinksName.text =  drinksList[indexPath.row]
        
        if indexPath.row == self.selectedIndexPath{
            cell.drinksQunatity.text = "\(self.selectedCount)"
        }else{
            cell.drinksQunatity.text = "\(0)"
        }
        
        cell.tag = indexPath.row
        cell.clickComplition = { (count, index) in
            self.selectedIndexPath = index
            self.selectedCount = count
            collectionView.reloadData()
        }
        return cell
    }

}
