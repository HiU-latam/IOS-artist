//
//  SettingsItemTableViewCell.swift
//  HiU
//
//  Created by Pranshi on 8/3/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SettingsItemTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var imageVerticalLine: UIImageView!
    @IBOutlet weak var imageSelection: UIImageView!
    @IBOutlet weak var labelSettingsItemTitle: UILabel!
    
    var settingsNumberRequestitem: SettingsNumberRequest?{
        didSet{
            guard let item = settingsNumberRequestitem else {
                return
            }
            
            
            if item.selected == "Yes" {
                imageSelection.image = UIImage(named:"menu_active_orange")
            }else{
                imageSelection.image = UIImage(named:"menu_non_act_not_selected")
            }
            labelSettingsItemTitle.text = item.name
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
}
