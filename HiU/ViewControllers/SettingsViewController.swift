//
//  SettingsViewController.swift
//  HiU
//
//  Created by Shiny solutions
//  Created on 7/23/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Declaration
    var settingsSection = [SettingsSectionModal]()
    var settingsRow = [SettingsRowModal]()
    var expandedSectionHeaderNumber: Int = -1
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeader: UITableViewHeaderFooterView!
    fileprivate let viewModel = SettingsSectionModal()
    
    
    //MARK: Outlet
    @IBOutlet weak var tableViewSettings: UITableView!
    @IBOutlet weak var labelProfilePhoto: UILabel!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var labelPrfole: UILabel!
    @IBOutlet weak var buttonEdit: UIButton!
    
    //MARK: Outlet action

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        prepareTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareProfile()
        
        
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Preprare profile
    func prepareProfile() {
        labelProfilePhoto.layer.cornerRadius = 40
        labelProfilePhoto.layer.masksToBounds = true
        
        labelProfile.text = "Leonardo Test"
        labelProfile.font = UIFont.appFontLarge()
        
        labelPrfole.text = NSLocalizedString("profile", comment: "")
        labelPrfole.font = UIFont.appFontMedium()
        labelPrfole.textColor = Helper.appThemeColor()
        
        buttonEdit.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        buttonEdit.titleLabel?.font = UIFont.appFontSmall()
        buttonEdit.setTitleColor(Helper.appThemeGray(), for: .normal)
    }
    
    //MARK: Prepare Table view
    func prepareTableView() {
        
        NSLog("prepareTableView", "")
        
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableViewSettings?.beginUpdates()
            self?.tableViewSettings?.reloadSections([section], with: .fade)
            self?.tableViewSettings?.endUpdates()
        }
        
        tableViewSettings?.estimatedRowHeight = 100
        tableViewSettings?.rowHeight = UITableViewAutomaticDimension
        tableViewSettings?.sectionHeaderHeight = 70
        tableViewSettings?.separatorStyle = .none
        tableViewSettings?.dataSource = viewModel
        tableViewSettings?.delegate = viewModel
        tableViewSettings?.register(SettingsItemTableViewCell.nib, forCellReuseIdentifier: SettingsItemTableViewCell.identifier)
        tableViewSettings?.register(SettingsCharityPreferenceTableViewCell.nib, forCellReuseIdentifier: SettingsCharityPreferenceTableViewCell.identifier)
        tableViewSettings?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }

}
