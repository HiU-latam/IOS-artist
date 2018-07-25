//
//  ViewController.swift
//  HiU
//
//  Created by Lady Diana Cortes on 18/09/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: DECLARATION
    var counter = 0
    var timer = Timer()
    
    @IBOutlet var splashView: UIImageView!
    
    //MARK: OVERRIDE METHODS
    override func viewDidLoad() {
       super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        splashView.animationRepeatCount=1
        let jeremyGif = UIImage.gif(name: "gif_splash")
        
        
        
        
        // Uncomment the next line to prevent stretching the image
        // imageView.contentMode = .ScaleAspectFit
        // Uncomment the next line to set a gray color.
        // You can also set a default image which get's displayed
        // after the animation
        // imageView.backgroundColor = UIColor.grayColor()
        
        // Set the images from the UIImage
        splashView.animationImages = jeremyGif?.images
        // Set the duration of the UIImage
        splashView.animationDuration = jeremyGif!.duration
        // Set the repetitioncount
        splashView.animationRepeatCount = 1
        // Start the animation
        splashView.startAnimating()
        
        runTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SET TIMER
    func runTimer() {
        NSLog("runTimer")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func update(){
        counter += 1
        NSLog(timer.isValid ? "YES" : "NO")
        NSLog("\(counter)")
        if counter >= 18 {
            timer.invalidate()
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }


}

