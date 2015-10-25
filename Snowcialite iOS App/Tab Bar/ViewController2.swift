//
//  ViewController2.swift
//  Snowcialite iOS App
//
//  Created by Deniz Tolga Turgut on 10/12/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit

class ViewController2: UIViewController
{
    var sampleString: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "This is a new screen!"
        label.sizeToFit()
        label.center = self.view.center
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
