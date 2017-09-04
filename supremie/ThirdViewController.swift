//
//  ThirdViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource
{
    var noodleList = [String]()
    var noodleIdList = [Int]()
    var noodleFlavor:String = ""
    var selectedIndexPath:Int = 0
    var selectedCount:Int = 0
    
    @IBAction func noodleRed(_ sender: Any) {
    }
    @IBOutlet weak var noodleCollectionView: UICollectionView!
    
    @IBOutlet weak var noodleButton: UIButton!

    @IBAction func noodelAction(_ sender: Any) {
        
        for item in InfoDetail.sharedInstant.objItem.mie
        {
            if item.id == selectedIndexPath + 1 && item.flavour ==  noodleFlavor {
                InfoDetail.id = selectedIndexPath + 1
                InfoDetail.quantity_mie = selectedCount
                InfoDetail.price = item.price
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in InfoDetail.sharedInstant.objItem.mie
        {
            if item.stock>3 && item.brand ==  InfoDetail.selectedName {
                noodleList.append(item.flavour)
                noodleIdList.append(item.id)
            }
        }

        // For Button and title in navigation bar
        self.title = "Pilih Rasa"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 19, height: 49)
        btnLeftMenu.addTarget(self, action: #selector(ThirdViewController.onClcikBack), for: UIControlEvents.touchUpInside)
        
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
        noodleCollectionView.collectionViewLayout = layout
        
    }
    
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if(selectedIndexPath == indexPath.row){
            if (selectedCount < 3){
                selectedIndexPath = indexPath.row
                selectedCount = selectedCount + 1
                collectionView.reloadData()
            }
        }else {
            selectedIndexPath = indexPath.row
            selectedCount = 1
            collectionView.reloadData()
        }
        if (selectedCount == 0){
            self.noodleButton.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
        }else{
            noodleButton.backgroundColor=UIColor.red
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return noodleList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"noodleCell", for: indexPath) as! noodleCollectionViewCell
        
        if ((UIImage(named: noodleList[indexPath.row])) != nil){
            cell.noodlePicture.image = UIImage(named: noodleList[indexPath.row])
        }else{
            cell.noodlePicture.image = UIImage(named: "Default")
        }
        
        cell.noodleName.text =  noodleList[indexPath.row]
        
        if indexPath.row == self.selectedIndexPath{
            
            cell.noodleQunatity.text = "\(self.selectedCount)"
        }else{
            cell.noodleQunatity.text = "\(0)"
            
        }
        cell.tag = indexPath.row

        cell.clickComplition = { (count, index) in
            
            self.noodleFlavor = self.noodleList[indexPath.row]
            self.selectedIndexPath = index
            self.selectedCount = count
            if (self.selectedCount == 0){
                self.noodleButton.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
            }else{
                self.noodleButton.backgroundColor=UIColor.red
            }
            collectionView.reloadData()
        }
        
        return cell
    }
    
}
