//
//  MountainReportViewController.swift
//  Snowcialite iOS App

//
//  Created by Deniz Turgut on 10/4/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MountainReportViewController: UIViewController, UITextFieldDelegate
{
    //storyboard reference variables
    @IBOutlet weak var getCurrentTempButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    
    //class variables
    var weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        
        getWeatherData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData()
    {
        Alamofire.request(.GET, weatherBaseURL, parameters: ["q": cityTextField.text!, "APPID": "6be1b1956ac65ae6ed8ac3fa17402547", "units": "imperial"]).responseJSON
        { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.result)   // result of response serialization

            let json = JSON(response.result.value!)
            self.cityTemperatureLabel.text = json["main"]["temp"].stringValue + "° F"
        }
        
        print("getFunctionButtonTapped")
    }
    
    @IBAction func getCurrentTempButtonTapped(sender: AnyObject)
    {
        getWeatherData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "showNextScreen"
        {
            let vc = segue.destinationViewController as! ViewController2
            
            vc.sampleString = "This is how you set a string for a view controller before you push it!"
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        dispatch_async(dispatch_get_main_queue(),
        {
            self.getWeatherData()
        })
        
        return true
    }
}

