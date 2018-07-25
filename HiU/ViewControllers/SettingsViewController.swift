//
//  SettingsViewController.swift
//  HiU
//
//  Created by Shiny solutions
//  Created on 7/23/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Declaration
    
    //MARK: Outlet
    @IBOutlet weak var tableViewSettings: UITableView!
    
    //MARK: Outlet action

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareTableView()
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Prepare Table view
    func prepareTableView() {
        tableViewSettings.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:SettingsProfileTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "SettingsProfileTableViewCell", for: indexPath) as? SettingsProfileTableViewCell)!
            
            cell.labelPhoto.layer.cornerRadius = 40
            cell.labelPhoto.layer.masksToBounds = true
            
            cell.labelProfileName.text = "Leonardo Test"
            cell.labelProfileName.font = UIFont(name: "Nanami", size: 16.0)
            
            cell.labelProfile.text = NSLocalizedString("profile", comment: "")
            cell.labelProfile.font = UIFont(name: "Nanami", size: 12.0)
            
            cell.buttonEdit.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
            cell.buttonEdit.titleLabel?.font = UIFont(name: "Nanami", size: 8.0)
            cell.buttonEdit.setTitleColor(Helper.UIColorFromRGB(rgbValue: UInt(Helper.appThemeColor)), for: .normal)
            
            return cell
        }else{
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 108
        }else{
            return 0.0
        }
    }

}
