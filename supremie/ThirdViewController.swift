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
    var noodleList = ["vsoAyamBawang","vsoCabeIjo","vsoGoreng","vsoKariAyam","vsoRendang","vsoSotoMie"]
    
    override func viewDidLoad() {
        
        print("hello")
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return noodleList.count
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"noodleCell", for: indexPath) as! noodleCollectionViewCell
        
        cell.noodlePicture.image = UIImage(named: noodleList[indexPath.row])
        
        cell.noodleName.text =  noodleList[indexPath.row]
        print(noodleList[indexPath.row])
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
