//
//  RequestsViewController.swift
//  HiU
//
//  Created by Shiny solutions
//  Created on 6/27/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import DropDown
import QuartzCore

class RequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: Declaration
    var navigationBarLabel = UILabel.init()
    var leftBarButtonItem = UIBarButtonItem.init()
    var rightBarButtonItem = UIBarButtonItem.init()
    var rightSearchBarButtonItem = UIBarButtonItem.init()
    var leftBackBarButtonItem = UIBarButtonItem.init()
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    let tabBarItemTitles = [NSLocalizedString("name", comment: ""), NSLocalizedString("category", comment: ""), NSLocalizedString("country", comment: "")]
    let monthArray = DropDown()
    var arrayRequestModal = [RequestModal]()

    //MARK: Outlet
    @IBOutlet weak var viewTab: UIView!
    @IBOutlet weak var labelMostRecents: UILabel!
    @IBOutlet weak var buttonMonth: UIButton!
    @IBOutlet weak var labelByName: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var tableRequests: UITableView!
    
    //MARK: Action
    @IBAction func chooseMonth(_ sender: Any) {
        monthArray.show()
    }
    
    //MARK: Override Methods
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
        
        prepareNavigation()
        
        prepareTabBar()
        
        prepareFilter()
        
        prepareResult()
        
        prepareSampleData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBarLabel.removeFromSuperview()
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func prepareNavigation() {
        
        self.slideMenuController()?.navigationController?.navigationBar.tintColor = Helper.appThemeColor()
        self.slideMenuController()?.navigationController?.navigationBar.barTintColor = Helper.appThemeColor()
        
        self.slideMenuController()?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        if let navigationBar = self.slideMenuController()?.navigationController?.navigationBar {
            let firstFrame = CGRect(x: (navigationBar.frame.size.width/2) - 80, y:(navigationBar.frame.size.height/2) - 10, width: 160, height:20)
            navigationBarLabel = UILabel(frame: firstFrame)
            navigationBarLabel.text = NSLocalizedString("requests", comment: "")
            navigationBarLabel.textColor = UIColor.white
            navigationBarLabel.textAlignment = NSTextAlignment.center
            navigationBarLabel.font = UIFont.appFontMedium()
            navigationBar.addSubview(navigationBarLabel)
        }
        
        self.slideMenuController()?.navigationItem.setHidesBackButton(true, animated: true)
        
        var leftBarButtonImge = UIImage(named: "menu")
        leftBarButtonImge = leftBarButtonImge?.withRenderingMode(.alwaysOriginal)
        leftBarButtonItem = UIBarButtonItem.init(
            image: leftBarButtonImge,
            style: .plain,
            target: self,
            action: #selector(openLeftMenu))
        
        self.slideMenuController()?.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        var rightBarButtonImge = UIImage(named: "charity_vertical_dots")
        rightBarButtonImge = rightBarButtonImge?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem = UIBarButtonItem.init(
            image: rightBarButtonImge,
            style: .plain,
            target: self,
            action: #selector(openRightMenu))
        
        var rightSearchBarButtonImge = UIImage(named: "charity_search_icon")
        rightSearchBarButtonImge = rightSearchBarButtonImge?.withRenderingMode(.alwaysOriginal)
        rightSearchBarButtonItem = UIBarButtonItem.init(
            image: rightSearchBarButtonImge,
            style: .plain,
            target: self,
            action: #selector(openSearchBar))
        
        self.slideMenuController()?.navigationItem.rightBarButtonItems = [rightBarButtonItem, rightSearchBarButtonItem]
    }
    
    func openLeftMenu(sender: UIButton)  {
        NSLog("openLeftMenu", "")
        let isLeftOpen = self.slideMenuController()?.isLeftOpen()
        if (isLeftOpen)! {
            self.slideMenuController()?.closeLeft()
        }else{
            self.slideMenuController()?.openLeft()
        }
    }
    
    func openRightMenu(sender: UIButton)  {
        NSLog("openRightMenu", "")
        openSettings(sender)
    }
    
    func openSettings(_ sender: UIButton!) {
        NSLog("openSettings", "")
        let settingsViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController")
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func openSearchBar(sender: UIButton)  {
        NSLog("openSearchBar", "")
        var leftBackBarButtonImge = UIImage(named: "back_icon")
        leftBackBarButtonImge = leftBackBarButtonImge?.withRenderingMode(.alwaysOriginal)
        leftBackBarButtonItem = UIBarButtonItem.init(
            image: leftBackBarButtonImge,
            style: .plain,
            target: self,
            action: #selector(resetMenu))
        
        self.slideMenuController()?.navigationItem.leftBarButtonItem = leftBackBarButtonItem
        self.slideMenuController()?.navigationItem.rightBarButtonItems = nil
        self.navigationBarLabel.removeFromSuperview()
        
        searchBar.placeholder = NSLocalizedString("search", comment: "")
        self.slideMenuController()?.navigationItem.titleView = searchBar
        
        
    }
    
    func resetMenu(sender: UIButton)  {
        self.slideMenuController()?.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.slideMenuController()?.navigationItem.rightBarButtonItems = [rightBarButtonItem, rightSearchBarButtonItem]
        self.slideMenuController()?.navigationController?.navigationBar.addSubview(navigationBarLabel)
        
        self.slideMenuController()?.navigationItem.titleView = nil
    }
    
    // MARK: - Tab Bar
    func prepareTabBar() {
        NSLog("prepareTabBar", "")
        let screenSize = UIScreen.main.bounds
        let screenWidth =  screenSize.width
        let tabBarHeight = 50
        
        self.viewTab.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
        self.viewTab.backgroundColor = Helper.appThemeColor()
        
        let tabBarWidth = Int(self.viewTab.frame.width / 3)
        
        var currentIndex = 0
        
        for tabBarItemTitle in tabBarItemTitles {
            let buttonName = UIButton(type: UIButtonType.custom)
            buttonName.frame = CGRect(x: currentIndex * tabBarWidth, y: 0, width: tabBarWidth, height: tabBarHeight)
            buttonName.setTitle(tabBarItemTitle, for: .normal)
            buttonName.titleLabel?.font = UIFont.appFontMedium()
            buttonName.titleLabel?.textColor = UIColor.white
            buttonName.setBackgroundImage(UIImage(named: "history_tab_bg"), for: .selected)
            buttonName.setBackgroundImage(nil, for: .normal)
            buttonName.addTarget(self, action: #selector(buttonTabClicked), for: .touchUpInside)
            if currentIndex == 0{
                buttonName.isSelected = true
            }
            buttonName.tag = currentIndex
            self.viewTab.addSubview(buttonName)
            currentIndex = currentIndex + 1
        }
    }
    
    func buttonTabClicked(sender: UIButton!){
        NSLog("buttonTabClicked", "")
        NSLog(sender.currentTitle!)
        for tabBarItemTitle in self.viewTab.subviews {
            let isEqualTabBarTitle = (tabBarItemTitle.tag == sender.tag)
            let buttonItem = tabBarItemTitle as! UIButton
            NSLog("isEqualTabBarTitle", "")
            if (isEqualTabBarTitle){
                NSLog("true", "")
                buttonItem.isSelected = true
            }
        }
        
        for tabBarItemTitle in self.viewTab.subviews {
            let isEqualTabBarTitle = (tabBarItemTitle.tag == sender.tag)
            let buttonItem = tabBarItemTitle as! UIButton
            NSLog("isEqualTabBarTitle", "")
            if (!isEqualTabBarTitle){
                NSLog("false", "")
                buttonItem.isSelected = false
            }
        }
        
        prepareResult()
    }
    
    //MARK: Prepare UI
    func prepareFilter() {
        let completeText = NSMutableAttributedString(string: "")
        let textAfterIcon = NSMutableAttributedString(string: NSLocalizedString("most_recents", comment: ""))
        completeText.append(textAfterIcon)
        let attachmentImage = NSTextAttachment()
        attachmentImage.image = UIImage(named: "down_arrow_2")
        
        let imageOffsetY:CGFloat = -4.0
        
        attachmentImage.bounds = CGRect(x: 0, y: imageOffsetY, width: attachmentImage.image!.size.width, height: attachmentImage.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachmentImage)
        completeText.append(attachmentString)
        
        
        labelMostRecents.textAlignment = .left
        labelMostRecents.attributedText = completeText
        
        labelMostRecents.font = UIFont(name: "Nanami", size: 12.0)
        
        let formatter = DateFormatter()
        let monthComponents = formatter.shortMonthSymbols
        buttonMonth.backgroundColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1.0)
        buttonMonth.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        buttonMonth.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        buttonMonth.layer.shadowOpacity = 1.0
        buttonMonth.titleLabel?.textColor = UIColor.white
        buttonMonth.setTitle(NSLocalizedString("choose_month", comment: ""), for: .normal)
        monthArray.anchorView = buttonMonth
        monthArray.bottomOffset = CGPoint(x: 0, y: buttonMonth.bounds.height)
        monthArray.dataSource = monthComponents!
        monthArray.selectionAction = { [weak self] (index, item) in
            self?.buttonMonth.setTitle(item, for: .normal)            
        }
        
    }
    
    func prepareResult() {
        NSLog("%@", "RequestsViewController - prepareResult")
        
        labelByName.font = UIFont(name: "Nanami", size: 12.0)
        labelByName.textColor = Helper.appThemeColor()
        for tabBarItemTitle in self.viewTab.subviews {
            let buttonItem = tabBarItemTitle as! UIButton
            let isEqualTabBarTitle = buttonItem.isSelected
            if (isEqualTabBarTitle){
                buttonItem.isSelected = true
                let result = String(format: "%@ %@", "By", (buttonItem.titleLabel?.text)!)
                labelByName.text = result
            }
        }
        
        labelCount.font = UIFont(name: "Nanami", size: 12.0)
        labelCount.backgroundColor = Helper.appThemeColor()
        labelCount.textColor = UIColor.white
        labelCount.text = "10"
        labelCount.layer.backgroundColor = Helper.appThemeColor().cgColor
        labelCount.layer.cornerRadius = 10
        labelCount.layer.masksToBounds = true
        labelCount.textAlignment = .center
        
    }
    
    func prepareSampleData() {
        NSLog("%@", "prepareSampleData")
        
        arrayRequestModal.removeAll()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a - MMM dd, yyyy"
        
        NSLog("prepareSampleData - %@", formatter.string(from: date))
        
        var requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
        
        requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
        
        requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
        
        requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
        
        requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
        
        requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
        
        requestModal = RequestModal(name: "Mary Snow", date: formatter.string(from: date))
        arrayRequestModal.append(requestModal)
    }
    
    //MARK: Table Requests
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRequestModal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RequestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell") as! RequestTableViewCell!
        
        let requestModal = arrayRequestModal[indexPath.row]
        
        cell.labelPicture.backgroundColor = Helper.appThemeColor()
        cell.labelPicture.text = ""
        cell.labelPicture.layer.cornerRadius = 5
        cell.labelPicture.layer.masksToBounds = true
        
        cell.labelName.text = requestModal.mName
        cell.labelName.font = UIFont(name: "Nanami", size: 12.0)
        
        cell.labelDate.text = requestModal.mDate
        cell.labelDate.font = UIFont(name: "Nanami", size: 8.0)
        cell.labelDate.textColor = UIColor.gray
        
        cell.buttonReply.setTitle(NSLocalizedString("reply", comment: ""), for: .normal)
        cell.buttonReply.backgroundColor = Helper.appThemeColor()
        cell.buttonReply.setTitleColor(UIColor.white, for: .normal)
        cell.buttonReply.layer.cornerRadius = 5
        cell.buttonReply.layer.masksToBounds = true
        cell.buttonReply.addTarget(self, action: #selector(openRecordVideo(_:)), for: .touchUpInside)
        cell.buttonReply.tag = indexPath.row
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.00
    }
    
    func openRecordVideo(_ sender: UIButton!) {
        NSLog("openRecordVideo", "")
        let recordVideoViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecordVideoViewController")
        self.navigationController?.pushViewController(recordVideoViewController, animated: true)
    }
    
}
