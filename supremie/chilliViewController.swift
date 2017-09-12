//
//  chilliViewController.swift
//  supremie
//
//  Created by Jigar Thakkar on 2/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class chilliViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var noodleList = ["RP 0\nLEVEL 0 (TANPA BUBUK CABAI DIDALAM PACKAGING)","RP 0\nLEVEL 1 (HANYA BUBUK CABAI DIDALAM PACKAGING)","RP 1000\nLEVEL 2 (BUBUK CABAI DIDALAM PACKAGING + 5 CABAI RAWIT)","RP 2000\nLEVEL 3 (BUBUK CABAI DIDALAM PACKAGING + 20 CABAI RAWIT)"]
    var pictureList =  ["Level-0","Level-1","Level-2","Level-3"]
    var chilipriceList = [0,0,1000,2000]
    var selectedIndexPath:Int = 0
    var selectedCount:Int = 0
    
    @IBOutlet weak var chilliCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // For Button and title in navigation bar
        self.title = "PILIH LEVEL PEDAS"
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
        layout.itemSize = CGSize(width: (screenWidth)-8, height: (screenHeight/4)-40)
        
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
        
        cell.chilliPicture.image = UIImage(named: pictureList[indexPath.row])
        cell.chiliLabel.text = noodleList[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectedModel.sharedInstant.chilliLevel = indexPath.row
        SelectedModel.sharedInstant.chilliPrice = chilipriceList[indexPath.row]
        performSegue(withIdentifier: "chilliToDrinks", sender: self)
    }
}
