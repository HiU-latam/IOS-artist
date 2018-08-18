//
//  HeaderView.swift
//  TableViewWithMultipleCellTypes
//
//  Created by Stanislav Ostrovskiy on 5/21/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(header: HeaderView, section: Int)
    func updateNotification(_ sender: UIButton!, section: Int)
    func updateValueMinRequest(_ sender: UITextField!, section: Int)
}

class HeaderView: UITableViewHeaderFooterView {

    var item: SettingsSectionModalItem? {
        didSet {
            guard let item = item else {
                return
            }
            
            titleLabel?.text = item.name
            
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var arrowLabel: UIImageView?
    @IBOutlet weak var imageSettingsType: UIImageView!
    @IBOutlet weak var buttonNotification: UIButton!
    @IBOutlet weak var textValueMinRequest: UITextField!
    @IBOutlet weak var imageViewMenuBG: UIImageView!
    var section: Int = 0
    var maxLength: Int = 0
    
    weak var delegate: HeaderViewDelegate?
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSLog("awakeFromNib", "")
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        
        textValueMinRequest.delegate = self
    }
    
    func setCollapsed(collapsed: Bool) {
        NSLog("setCollapsed %@", collapsed ? "True" : "False")
        if collapsed {
            arrowLabel?.image = UIImage(named: "menu_collapse_icon")
        }else{
            arrowLabel?.image = UIImage(named: "menu_expand_icon")
        }
    }
    
    
    
    @IBAction func updateNotification(_ sender: Any) {
        delegate?.updateNotification(sender as! UIButton, section: section)
    }
    
    @IBAction func updateValueMinRequest(_ sender: UITextField) {
        delegate?.updateValueMinRequest(sender, section: section)
    }
    
    
    @objc private func didTapHeader() {
        NSLog("didTapHeader", "")
        delegate?.toggleSection(header: self, section: section)
    }
    
    
}


extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension HeaderView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSLog("shouldChangeCharactersIn", "")
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
}
