//
//  SecondViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 1/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrayCompanyList = [Drink]()
    
    var navBar: UINavigationBar = UINavigationBar()
    
    @IBOutlet weak var companyList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterArray()
                
        // For Button and title in navigation bar
        self.title = "PILIH MIE INSTAN"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100.0)
        
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "< Kembali", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClcikBack))
        navigationItem.leftBarButtonItem = backButton
        
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
        SelectedModel.sharedInstant.selectedMie = nil
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return arrayCompanyList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"companyLogoCell", for: indexPath) as! CompanyCollectionViewCell
        
        cell.noodlePrice.text = currencyFormat(currency:arrayCompanyList[indexPath.row].price)
        
        cell.objDrink.image =   UIImage(named: arrayCompanyList[indexPath.row].brand)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectedModel.sharedInstant.selectedMie = arrayCompanyList[indexPath.row]
        performSegue(withIdentifier: "secondToThird", sender: self)
        
    }
    
    private func filterArray() {
        var companys = [String]()
        for item in InfoDetail.sharedInstant.objItem.mie {
            companys.append(item.brand)
        }
    
        companys = Array(Set(companys))
        
        for filterName in companys {
            
            arrayCompanyList.append(InfoDetail.sharedInstant.objItem.mie.filter({ (item) -> Bool in
                return item.brand == filterName
            }).first!)
        }
    }
}

