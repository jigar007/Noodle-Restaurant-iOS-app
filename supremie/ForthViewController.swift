//
//  ForthViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
 
    var noodleList = ["vsoAyamBawang","vsoCabeIjo","vsoGoreng","vsoKariAyam","vsoRendang","vsoSotoMie"]
    
    override func viewDidLoad() {
        print("hello")
        
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
        
        super.viewDidLoad()
        
    }
    
    
    @IBOutlet weak var toppingsCollectionView: UICollectionView!
  
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return noodleList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"toppingsCell", for: indexPath) as! toppingsCollectionViewCell
        
        
        cell.toppingsPicture.image = UIImage(named: noodleList[indexPath.row])
        
        cell.toppingsName.text =  noodleList[indexPath.row]
        
        print(noodleList[indexPath.row])
        return cell
    }
}
