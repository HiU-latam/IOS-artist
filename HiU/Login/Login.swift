//
//  Login.swift
//  HiU
//
//  Created by Lady Diana Cortes on 15/10/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit
import AWSAuthUI
import AWSFacebookSignIn
import SlideMenuControllerSwift

class Login: UIViewController {

    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var labelLoginWith: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var labelSignup: UILabel!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var buttonSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//      presentAuthUIViewController()
        // Do any additional setup after loading the view.
        
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        
        // you can use properties like logoImage, backgroundColor to customize screen
        // config.canCancel = false // this will disallow end user to dismiss sign in screen
        
        // you should have a navigation controller for your view controller
        // the sign in screen is presented using the navigation controller
        
        AWSAuthUIViewController.presentViewController(
            with: navigationController!,  // you should have your navigation controller here
            configuration: config,
            completionHandler: {(
                _ signInProvider: AWSSignInProvider, _ error: Error?) -> Void in
                if error == nil {
                    DispatchQueue.main.async(execute: {() -> Void in
                        // handle successful callback here,
                        // e.g. pop up to show successful sign in
                    })
                }
                else {
                    // end user faced error while loggin in,
                    // take any required action here
                }
        })
    }
    
    //MARK: Prepare UI
    func prepareUI() {
        textUserName.layer.shadowColor = UIColor.black.cgColor
        textUserName.layer.shadowOpacity = 1
        textUserName.layer.shadowOffset = CGSize.zero
        textUserName.rightViewMode = UITextFieldViewMode.always
        let signInEmailRightImage = UIImage(named:"sign_in_check_icon")
        let signInEmailRightImageSize = signInEmailRightImage?.size
        let signInEmailRightImageWidth = signInEmailRightImageSize?.width
        let signInEmailRightImageHeight = signInEmailRightImageSize?.height
        let signInEmailRightImageView = UIImageView(frame: CGRect(x: (textUserName.frame.size.width - signInEmailRightImageWidth!), y: (textUserName.frame.size.height / 2) - (signInEmailRightImageHeight! / 2), width: signInEmailRightImageWidth! + 20, height:signInEmailRightImageHeight!))
        signInEmailRightImageView.contentMode = UIViewContentMode.center
        signInEmailRightImageView.image = signInEmailRightImage
        textUserName.rightView = signInEmailRightImageView
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textUserName.frame.size.height))
        textUserName.leftView = leftPaddingView
        textUserName.leftViewMode = UITextFieldViewMode.always
        
        textPassword.layer.shadowColor = UIColor.black.cgColor
        textPassword.layer.shadowOpacity = 1
        textPassword.layer.shadowOffset = CGSize.zero
        textPassword.leftViewMode = UITextFieldViewMode.always
        let signInPasswordLeftImage = UIImage(named:"sign_in_eye_active_icon")
        let signInPasswordLeftImageSize = signInPasswordLeftImage?.size
        let signInPasswordLeftImageWidth = signInPasswordLeftImageSize?.width
        let signInPasswordLeftImageHeight = signInPasswordLeftImageSize?.height
        let signInPasswordLeftImageView = UIImageView(frame: CGRect(x: 0, y: (textPassword.frame.size.height / 2) - (signInPasswordLeftImageHeight! / 2), width: signInPasswordLeftImageWidth! + 20, height:signInPasswordLeftImageHeight!))
        signInPasswordLeftImageView.contentMode = UIViewContentMode.center
        signInPasswordLeftImageView.image = signInPasswordLeftImage
        textPassword.leftView = signInPasswordLeftImageView
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textPassword.frame.size.height))
        textPassword.rightView = rightPaddingView
        textPassword.rightViewMode = UITextFieldViewMode.always
        
        labelLoginWith.text = NSLocalizedString("login_with", comment: "")
        labelLoginWith.font = UIFont.appFontSmall()
        labelLoginWith.textColor = UIColor.white
        labelLoginWith.contentMode = UIViewContentMode.center
        
        buttonLogin.setTitle(NSLocalizedString("sign_in", comment: ""), for: UIControlState.normal)
        buttonLogin.titleLabel?.font = UIFont.appFontMedium()
        buttonLogin.setTitleColor(UIColor.white, for: UIControlState.normal)
        buttonLogin.backgroundColor = Helper.appThemeColor()
        buttonLogin.addTarget(self, action: #selector(signInButtonOnClick), for: .touchUpInside)
        
        let attrTextNewhere = NSMutableAttributedString(string: String(format:"%@?", NSLocalizedString("new_here", comment: "")))
        attrTextNewhere.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, attrTextNewhere.length))
        let attrTextSignUp = NSMutableAttributedString(string: NSLocalizedString("sign_up", comment: ""))
        attrTextSignUp.addAttribute(NSForegroundColorAttributeName, value: Helper.appThemeColor(), range: NSMakeRange(0, attrTextSignUp.length))
        let attributedText = NSMutableAttributedString()
        attributedText.append(attrTextNewhere)
        attributedText.append(attrTextSignUp)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        buttonSignup.setAttributedTitle(attributedText, for: .normal)
        buttonSignup.titleLabel?.font = UIFont.appFontMedium()
    }
    
    func signInButtonOnClick(sender: UIButton!) {
        NSLog("signInButtonOnClick", "")
        
        let leftMenuviewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
        let requestViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestsViewController")
        let slideMenuController = SlideMenuController(mainViewController: requestViewController, leftMenuViewController: leftMenuviewController)
        NSLog("signInButtonOnClick - %@", slideMenuController)
        self.navigationController?.pushViewController(slideMenuController, animated: true)
    }
}
