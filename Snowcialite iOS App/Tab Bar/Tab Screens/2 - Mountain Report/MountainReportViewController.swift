//
//  MountainReportViewController.swift
//  Snowcialite iOS App
//
//  Created by Deniz Turgut on 10/4/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import Alamofire

class MountainReportViewController: UIViewController {
    
    var weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    var baseURL = "http://localhost:8081/SpringMVC/rest"
    var serviceRoute = "/user/"
    @IBOutlet weak var getCurrentTempButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var getFunctionButton: UIButton!
    @IBOutlet weak var postFunctionButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dispatch_async(dispatch_get_main_queue(),{
            self.getWeatherData()
        })
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData()
    {
        Alamofire.request(.GET, weatherBaseURL, parameters: ["q": cityTextField.text!, "APPID": "1a86e8933e6b874cedca14f2842a54c8"]).responseJSON
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
    
    @IBAction func getCurrentTempButtonTapped(sender: AnyObject)
    {
        getWeatherData()
    }
    
    @IBAction func getFunctionButtonTapped(sender: AnyObject)
    {
        Alamofire.request(.GET, baseURL + serviceRoute + "Deniz", parameters: nil).responseJSON
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
        Alamofire.request(.GET, baseURL + serviceRoute + "Deniz", parameters: nil).responseJSON
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
        
        print("postFunctionButtonTapped")
    }
}

