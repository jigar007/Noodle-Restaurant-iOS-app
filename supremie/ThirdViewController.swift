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
    
    var flavourList = InfoDetail.sharedInstant.objItem.mie.filter { (company) -> Bool in
        return company.brand == SelectedModel.sharedInstant.selectedMie?.brand && company.stock >= 3
    }
    
    @IBAction func noodleRed(_ sender: Any) {
    }
    @IBOutlet weak var noodleCollectionView: UICollectionView!
    
    @IBOutlet weak var noodleButton: UIButton!
    
    @IBAction func noodelAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(InfoDetail.sharedInstant.objItem.mie.count)
        
        //        for item in InfoDetail.sharedInstant.objItem.mie
        //        {
        //            if item.stock>3 && item.brand ==  InfoDetail.selectedName {
        //                noodleList.append(item.flavour)
        //                noodleIdList.append(item.id)
        //            }
        //        }
        
        
        
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
        
        let cell = collectionView.cellForItem(at: indexPath) as? noodleCollectionViewCell
        cell?.increnmentValue()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return  flavourList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"noodleCell", for: indexPath) as! noodleCollectionViewCell
        
        cell.objCompany = flavourList[indexPath.row]
        
        cell.tag = indexPath.row
        
        cell.clickComplition = { (count, index) in
            self.enableDisableNextButton()
            self.resetCountVariable()
            cell.updateStatus(count: count)
            
            cell.backgroundColor = UIColor.white
            
            if (count == 0){
                self.noodleButton.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
            }else{
                self.noodleButton.backgroundColor = UIColor(red: 227/255, green: 41/255, blue: 48/255, alpha: 1.0)
            }
        }
        
        return cell
    }
    
    private func resetCountVariable() {
        flavourList = flavourList.map { (drink:Drink) -> Drink in
            drink.count = 0
            return drink
        }
        
        noodleCollectionView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "thirdToForth" {
            
        }
    }
    
    func enableDisableNextButton()  {
        let tempList = flavourList.filter { (flavour) -> Bool in
            return flavour.count > 0
        }
        
        guard tempList.count > 0 else {
            noodleButton.isEnabled = false
            return
        }
        
        noodleButton.isEnabled = true
    }
}
