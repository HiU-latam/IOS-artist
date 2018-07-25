//
//  RecordVideoViewController.swift
//  HiU
//
//  Created by Shiny Solutions on 7/11/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import SCRecorder

class RecordVideoViewController: UIViewController, SCRecorderDelegate {

    //MARK: Declaration
    var navigationBarLabel = UILabel.init()
    var rightBarButtonItem = UIBarButtonItem.init()
    var leftBackBarButtonItem = UIBarButtonItem.init()
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    let session = SCRecordSession()
    let recorder = SCRecorder()
    
    //MARK: Outlet
    @IBOutlet weak var previewView: UIView!
    
    //MARK: Outlet action
    @IBAction func recordVideo(_ sender: Any) {
        recorder.record()
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        prepareRecorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareNavigation()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBarLabel.removeFromSuperview()
        
    }
    
    override func viewDidLayoutSubviews() {
        recorder.previewView = previewView
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func prepareNavigation() {
        
        self.navigationController?.navigationBar.tintColor = Helper.UIColorFromRGB(rgbValue: 0x16262f)
        self.navigationController?.navigationBar.barTintColor = Helper.UIColorFromRGB(rgbValue: 0x16262f)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: (navigationBar.frame.size.width/2) - 80, y:(navigationBar.frame.size.height/2) - 10, width: 160, height:20)
            navigationBarLabel = UILabel(frame: firstFrame)
            navigationBarLabel.text = NSLocalizedString("record_video", comment: "")
            navigationBarLabel.textColor = Helper.UIColorFromRGB(rgbValue: 0xcf00d2)
            navigationBarLabel.textAlignment = NSTextAlignment.center
            navigationBarLabel.font = Fonts.Medium
            navigationBar.addSubview(navigationBarLabel)
        }
        
        var leftBackBarButtonImge = UIImage(named: "back_icon")
        leftBackBarButtonImge = leftBackBarButtonImge?.withRenderingMode(.alwaysOriginal)
        leftBackBarButtonItem = UIBarButtonItem.init(
            image: leftBackBarButtonImge,
            style: .plain,
            target: self,
            action: #selector(backPressed))
        
        self.navigationItem.leftBarButtonItem = leftBackBarButtonItem
        
        var rightBarButtonImge = UIImage(named: "icon_plus")
        rightBarButtonImge = rightBarButtonImge?.withRenderingMode(.alwaysOriginal)
        let buttonAdd = UIButton(frame: CGRect(x: (self.navigationController?.navigationBar.bounds.width)! - 50, y: 0, width: 50, height: (self.navigationController?.navigationBar.bounds.height)!))
        buttonAdd.backgroundColor = Helper.UIColorFromRGB(rgbValue: 0xcf00d2)
        buttonAdd.setImage(rightBarButtonImge, for: .normal)
        buttonAdd.addTarget(self, action: #selector(openRightMenu(_:)), for: .touchUpInside)
        rightBarButtonItem = UIBarButtonItem.init(
            customView: buttonAdd)
        
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem]
    }
    
    func openRightMenu(_ sender: UIButton)  {
        NSLog("openRightMenu", "")
    }
    
    func backPressed(sender: UIButton)  {
        NSLog("CharityViewController - backPressed", "")
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: SC Recorder
    func prepareRecorder() {
        if (!recorder.startRunning()) {
            return
        }
        
        recorder.session = session
        recorder.device = AVCaptureDevicePosition.front
        recorder.videoConfiguration.size = CGSize(width: 800, height: 800)
        recorder.delegate = self
    }
    
}
