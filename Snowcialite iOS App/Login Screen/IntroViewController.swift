//
//  ViewController.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 11/12/15.
//  Copyright © 2016 Snowcialite. All rights reserved.
//

import UIKit


class IntroViewController: VideoSplashViewController {

    @IBOutlet weak var enterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        enterButton.backgroundColor = UIColor.whiteColor()
        enterButton.layer.cornerRadius = 5.0
        enterButton.layer.masksToBounds = true
        self.hidesBottomBarWhenPushed = true
        self.navigationItem.hidesBackButton = true
        enterButton.userInteractionEnabled = true
        self.navigationController!.navigationBarHidden = true;
    }

    @IBAction func enterButtonPressed(sender: AnyObject)
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    private func setupVideoBackground()
    {
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("video", ofType: "mov")!)
    
        interaction = false
        videoFrame = view.frame
        fillMode = .ResizeAspectFill
        alwaysRepeat = true
        sound = false
        startTime = 0
        duration = 12.0
        alpha = 0.7
        backgroundColor = UIColor.blackColor()
        
        contentURL = url
//        userInteractionEnabled = false
    }
    
}
