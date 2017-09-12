
//
//  Extension.swift
//  supremie
//
//  Created by Aman Prajapati on 9/8/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func makeHilighted()  {
        self.backgroundColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1.0)
    }
    
    func makeNormal()  {
        self.backgroundColor = UIColor.white
    }
}

extension UIViewController{
    
    func currencyFormat(currency:Int) -> String {
        // Currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "DE")
        return "RP "+String(describing: formatter.string(from: currency as NSNumber)!)
    }
    
    func navigationBar(title:String){
        // For Button and title in navigation bar
        let tlabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 200, height: 40)))
        tlabel.text = title
        tlabel.font = UIFont(name: "Helvetica", size: 25.0)
        tlabel.textColor = UIColor.white
        tlabel.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = tlabel
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100.0)
        
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "< Kembali", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClcikBack))
        backButton.accessibilityFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let customFont = UIFont(name: "Helvetica", size: 25.0)!
        
        backButton.setTitleTextAttributes([NSFontAttributeName: customFont], for: .normal)
        navigationItem.leftBarButtonItem = backButton
    }
    func onClcikBack() {
    }
    
}
