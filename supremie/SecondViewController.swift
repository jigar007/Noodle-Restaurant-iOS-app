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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "PILIH MIE INSTAN"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]


        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]

        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 19, height: 49)
        btnLeftMenu.addTarget(self, action: #selector(SecondViewController.onClcikBack), for: UIControlEvents.touchUpInside)
        
        btnLeftMenu.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    
        companyList.dataSource=self
        companyList.delegate=self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func onClcikBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var companyList: UICollectionView!
    
    
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
