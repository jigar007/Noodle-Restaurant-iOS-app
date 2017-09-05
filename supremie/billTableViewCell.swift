//
//  billTableViewCell.swift
//  supremie
//
//  Created by Jigar Thakkar on 3/9/17.
//  Copyright © 2017 JigarThakkar. All rights reserved.
//

import UIKit

class billTableViewCell: UITableViewCell {

    @IBOutlet weak var iteamName: UILabel!
    @IBOutlet weak var Qty: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
