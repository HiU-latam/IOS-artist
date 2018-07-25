//
//  SettingsProfileTableViewCell.swift
//  HiU
//
//  Created by Shiny solutions
//  Created on 7/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SettingsProfileTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var labelPhoto: UILabel!
    @IBOutlet weak var labelProfileName: UILabel!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var buttonEdit: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
