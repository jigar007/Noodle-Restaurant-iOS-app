//
//  SecondViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    var companyNamesList = ["vsoIndomie","vsoNongshim","vsosamyang","vsoSedap"]
    var navBar: UINavigationBar = UINavigationBar()

    @IBOutlet weak var companyList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        for item in InfoDetail.sharedInstant.objItem.mie{
        //            print(item.brand!)
        //        }
        //
        
        // For Button and title in navigation bar
        self.title = "PILIH MIE INSTAN"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100.0)
        
        let btnLeftMenu: UIButton = UIButton()
        
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 10, y: 10, width: 50 , height: 100)
        
        btnLeftMenu.addTarget(self, action: #selector(SecondViewController.onClcikBack), for: UIControlEvents.touchUpInside)
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
        companyList.collectionViewLayout = layout
        
    }
    
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return companyNamesList.count

    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"companyLogoCell", for: indexPath) as! CompanyCollectionViewCell
            
            cell.company.image = UIImage(named: companyNamesList[indexPath.row])
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "secondToThird", sender: self)
        print(indexPath)

    }
    
}
