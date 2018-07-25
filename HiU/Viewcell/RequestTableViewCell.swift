//
//  RequestTableViewCell.swift
//  HiU
//
//  Created by Shiny Solutions on 7/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var labelPicture: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonReply: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
