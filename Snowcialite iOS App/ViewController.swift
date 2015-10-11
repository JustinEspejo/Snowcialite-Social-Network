//
//  ViewController.swift
//  Snowcialite iOS App
//
//  Created by Syed Jilany on 10/4/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var getFunctionButton: UIButton!
    @IBOutlet weak var postFunctionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getFunctionButtonTapped(sender: AnyObject)
    {
        Alamofire.request(.GET, "http://localhost:8081/SpringMVC/rest/kfc/brands/", parameters: ["name": "Syed"]).responseJSON
        { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value
                {
                    print("JSON: \(JSON)")
                }
        }
        
        print("getFunctionButtonTapped")
    }
    
    @IBAction func postFunctionButtonTapped(sender: AnyObject)
    {
        print("postFunctionButtonTapped")
    }
}

