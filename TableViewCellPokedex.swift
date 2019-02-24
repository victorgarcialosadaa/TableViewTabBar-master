//
//  TableViewCellPokedex.swift
//  TableViewTabBar
//
//  Created by dmorenoar on 22/12/18.
//  Copyright © 2018 DAM. All rights reserved.
//

import UIKit

class TableViewCellPokedex: UITableViewCell {

    

    @IBOutlet weak var dogImg: UIImageView!
    
    @IBOutlet weak var dogCountry: UILabel!
    @IBOutlet weak var dogName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
