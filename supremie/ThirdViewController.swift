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
        let tempList = flavourList.filter { (flavour) -> Bool in
            return flavour.count > 0
        }
        
        guard tempList.count > 0 else {
            return
        }
        
        performSegue(withIdentifier: "thirdToForth", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Button and title in navigation bar
        navigationItem.hidesBackButton = true
        self.title = "Pilih Rasa"
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
        noodleCollectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func onClcikBack() {
        SelectedModel.sharedInstant.selectedMie = nil
        InfoDetail.sharedInstant.objItem.mie = InfoDetail.sharedInstant.objItem.mie.map { (object) -> Drink in
            object.count = 0
            return object
        }
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
            
            if (count == 0){
                self.noodleButton.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
            }else{
                self.noodleButton.backgroundColor = UIColor(red: 227/255, green: 41/255, blue: 48/255, alpha: 1.0)
            }
            self.enableDisableNextButton()
            self.resetCountVariable()
            cell.updateStatus(count: count)
            cell.backgroundColor = UIColor.white
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
            noodleButton.backgroundColor = UIColor.gray
            return
        }
        noodleButton.backgroundColor = UIColor.red
        noodleButton.isEnabled = true
    }
}
