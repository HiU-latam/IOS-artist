//
//  SettingsSectionModal.swift
//  HiU
//
//  Created by Shiny solutions on 7/26/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SettingsSectionModal: NSObject {
    var items = [SettingsSectionModalItem]()
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    override init() {
        super.init()
        guard let data = dataFromFile("SettingsData"), let settingsItem = Settings(data: data) else {
            return
        }
        NSLog("SettingsSectionModal - init", "")
        
        let settingsNumberRequest = settingsItem.settingsNumberRequests
        if !settingsItem.settingsNumberRequests.isEmpty {
            let settingsNumberRequestItem = SettingsViewNumberRequestModalItem(settingsNumberRequest: settingsNumberRequest)
            items.append(settingsNumberRequestItem)
        }
        
        let settingsCharityPreference = settingsItem.settingsCharityPreferences
        if !settingsItem.settingsCharityPreferences.isEmpty {
            let settingsCharityPreferenceItem = SettingsViewCharityPreferencesModalItem(settingsCharityPreference: settingsCharityPreference)
            items.append(settingsCharityPreferenceItem)
        }
        
        let notificationItem = SettingsViewNotificationModalItem()
        items.append(notificationItem)
        
        let valueMinRequestItem = SettingsViewMinRequestModalItem()
        items.append(valueMinRequestItem)
        
        let balanceItem = SettingsViewBalanceModalItem()
        items.append(balanceItem)
    }
    
    func setLeftView(color: UIColor) -> UILabel{
        let labelCurrencySymbol = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        labelCurrencySymbol.text = "$"
        labelCurrencySymbol.textColor = color
        return labelCurrencySymbol
    }

}

extension SettingsSectionModal: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        NSLog("numberOfSections", "")
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("numberOfRowsInSection", "")
        let item = items[section]
        guard item.isCollapsible else {
            return item.rowCount
        }
        
        if item.isCollapsed {
            return 0
        } else {
            return item.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("cellForRowAt", "")
        let item = items[indexPath.section]
        switch item.type {
        case .Number:
            if let item = item as? SettingsViewNumberRequestModalItem, let cell = tableView.dequeueReusableCell(withIdentifier: SettingsItemTableViewCell.identifier, for: indexPath) as? SettingsItemTableViewCell {
                let settingsNumberRequest = item.settingsNumberRequests[indexPath.row]
                cell.settingsNumberRequestitem = settingsNumberRequest
                return cell
            }
        case .Charity:
            if let item = item as? SettingsViewCharityPreferencesModalItem, let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCharityPreferenceTableViewCell.identifier, for: indexPath) as? SettingsCharityPreferenceTableViewCell {
                let settingsCharityPreference = item.settingsCharityPreference[indexPath.row]
                cell.settingsCharityPreferenceitem = settingsCharityPreference
                return cell
            }
        case .Notification:
            return UITableViewCell()
        case .Value:
            return UITableViewCell()
        case .Balance:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension SettingsSectionModal: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        NSLog("viewForHeaderInSection", "")
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView {
            let item = items[section]
            
            headerView.buttonNotification.isHidden = true
            headerView.textValueMinRequest.isHidden = true
            headerView.textValueMinRequest.leftViewMode = .always
            headerView.maxLength = 0
            headerView.imageViewMenuBG.isHidden = false
            switch item.type {
            case .Number:
                headerView.imageSettingsType.image = nil
            case .Charity:
                headerView.imageSettingsType.image = UIImage(named: "menu_news_icon")
            case .Notification:
                headerView.imageSettingsType.image = UIImage(named: "menu_users_icon")
                headerView.buttonNotification.isHidden = false
                headerView.buttonNotification.isSelected = UserDefaults.standard.bool(forKey: "SettingsNotification")
            case .Value:
                headerView.imageSettingsType.image = UIImage(named: "menu_money_icon")
                headerView.textValueMinRequest.isHidden = false
                headerView.textValueMinRequest.text = UserDefaults.standard.string(forKey: "SettingsValueMinRequest")
                headerView.textValueMinRequest.textColor = UIColor.white
                headerView.textValueMinRequest.leftView = setLeftView(color: UIColor.white)
                headerView.textValueMinRequest.backgroundColor = Helper.appThemeColor()
                headerView.maxLength = 2
            case .Balance:
                headerView.imageSettingsType.image = nil
                headerView.textValueMinRequest.isHidden = false
                headerView.maxLength = 3
                headerView.textValueMinRequest.backgroundColor = UIColor.clear
                headerView.textValueMinRequest.textColor = UIColor.black
                headerView.textValueMinRequest.leftView = setLeftView(color: UIColor.black)
                headerView.textValueMinRequest.text = UserDefaults.standard.string(forKey: "SettingsValueBalance")
                
                headerView.imageViewMenuBG.isHidden = true
                
                headerView.titleLabel?.font = UIFont.appFontVeryLarge()
            }
            
            NSLog("viewForHeaderInSection - name: %@", item.name)
            
            headerView.titleLabel?.text = item.name
            headerView.titleLabel?.font = UIFont.appFontLarge()
            headerView.titleLabel?.textColor = UIColor.blue
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
}

extension SettingsSectionModal: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        NSLog("toggleSection", "")
        var item = items[section]
        if item.isCollapsible {
            
            // Toggle collapse
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
    func updateNotification(_ sender: UIButton!, section: Int){
        let item = items[section]
        if item.isCollapsible {
            
            if sender.isSelected {
                sender.isSelected = false
            }else{
                sender.isSelected = true
            }
            UserDefaults.standard.set(sender.isSelected, forKey: "SettingsNotification")
            
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
    
    func updateValueMinRequest(_ sender: UITextField!, section: Int){
        let item = items[section]
        if item.isCollapsible {
            
            if item.type == SectionType.Value {
                UserDefaults.standard.set(sender.text, forKey: "SettingsValueMinRequest")
            }else if item.type == SectionType.Balance   {
                UserDefaults.standard.set(sender.text, forKey: "SettingsValueBalance")
            }
            
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
}

enum SectionType: String {
    case Number
    case Charity
    case Notification
    case Value
    case Balance
}

protocol SettingsSectionModalItem {
    var name: String { get }
    var type: SectionType { get }
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension SettingsSectionModalItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

class SettingsViewNumberRequestModalItem: SettingsSectionModalItem {
    
    
    var type: SectionType {
        return .Number
    }
    
    var isCollapsible: Bool {
        return true
    }
    
    var name: String {
        return NSLocalizedString("number_requests_allowed", comment: "")
    }
    
    var rowCount: Int {
        return settingsNumberRequests.count
    }
    
    var isCollapsed = true
    
    var settingsNumberRequests: [SettingsNumberRequest]
    
    init(settingsNumberRequest: [SettingsNumberRequest]) {
        NSLog("SettingsViewNumberRequestModalItem - init", "")
        self.settingsNumberRequests = settingsNumberRequest
    }
}

class SettingsViewCharityPreferencesModalItem: SettingsSectionModalItem {
    
    
    var type: SectionType {
        return .Charity
    }
    
    var name: String {
        return NSLocalizedString("my_charity_preference", comment: "")
    }
    
    var rowCount: Int {
        return settingsCharityPreference.count
    }
    
    var isCollapsed = true
    
    var settingsCharityPreference: [SettingsCharityPreferences]
    
    init(settingsCharityPreference: [SettingsCharityPreferences]) {
        NSLog("SettingsViewCharityPreferencesModalItem - init", "")
        self.settingsCharityPreference = settingsCharityPreference
    }
}

class SettingsViewNotificationModalItem: SettingsSectionModalItem {
    
    
    var type: SectionType {
        return .Notification
    }
    
    var name: String {
        return NSLocalizedString("notification", comment: "")
    }
    
    var rowCount: Int {
        return 0
    }
    
    var isCollapsed = true
}

class SettingsViewMinRequestModalItem: SettingsSectionModalItem {
    
    
    var type: SectionType {
        return .Value
    }
    
    var name: String {
        return NSLocalizedString("value_min_request", comment: "")
    }
    
    var rowCount: Int {
        return 0
    }
    
    var isCollapsed = true
}

class SettingsViewBalanceModalItem: SettingsSectionModalItem {
    
    
    var type: SectionType {
        return .Balance
    }
    
    var name: String {
        return NSLocalizedString("balance", comment: "")
    }
    
    var rowCount: Int {
        return 0
    }
    
    var isCollapsed = true
}
