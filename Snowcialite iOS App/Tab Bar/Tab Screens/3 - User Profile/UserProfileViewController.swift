//
//  UserProfileViewController.swift
//  Snowcialite iOS App

//
//  Created by Deniz Turgut on 10/4/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserProfileViewController: UIViewController
{
    //storyboard reference variables
    @IBOutlet weak var getFunctionButton: UIButton!
    @IBOutlet weak var postFunctionButton: UIButton!
    @IBOutlet weak var nextScreenButton: UIButton!
    
    //class variables
    var baseURL = "http://localhost:8081/SpringMVC/rest"
    var serviceRoute = "/user/"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getFunctionButtonTapped(sender: AnyObject)
    {
        Alamofire.request(.GET, baseURL + serviceRoute + "Deniz", parameters: nil).responseJSON
            { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                var json = JSON(response.result.value!)
        }
        
        print("getFunctionButtonTapped")
    }
    
    @IBAction func postFunctionButtonTapped(sender: AnyObject)
    {
        Alamofire.request(.GET, baseURL + serviceRoute + "Deniz", parameters: nil).responseJSON
            { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                let json = JSON(response.result.value!)
        }
        
        print("postFunctionButtonTapped")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "showNextScreen"
        {
            let vc = segue.destinationViewController as! ViewController2
            
            vc.sampleString = "This is how you set a string for a view controller before you push it!"
        }
    }
}

