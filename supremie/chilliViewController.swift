//
//  chilliViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class chilliViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var noodleList = ["vsoAyamBawang","vsoCabeIjo","vsoGoreng","vsoKariAyam","vsoRendang","vsoSotoMie"]
    var selectedIndexPath:Int = 0
    var selectedCount:Int = 0
    
    @IBOutlet weak var chilliCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // For Button and title in navigation bar
        self.title = "Pilih cabe meet"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 19, height: 49)
        btnLeftMenu.addTarget(self, action: #selector(chilliViewController.onClcikBack), for: UIControlEvents.touchUpInside)
        
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
        chilliCollectionView.collectionViewLayout = layout
    }
    
    
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return noodleList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"chilliCell", for: indexPath) as! chilliCollectionViewCell
        
        cell.chilliPicture.image = UIImage(named: noodleList[indexPath.row])
        cell.chilliName.text =  noodleList[indexPath.row]
        
        if indexPath.row == self.selectedIndexPath{
            cell.chilliQunatity.text = "\(self.selectedCount)"
        }else{
            cell.chilliQunatity.text = "\(0)"
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
