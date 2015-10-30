

import UIKit
import Alamofire
import SwiftyJSON

class MountainReportViewController: UIViewController, UITextFieldDelegate
{
    //storyboard reference variables
    @IBOutlet weak var getCurrentTempButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var snowLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    //class variables
    var weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather"

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        
        getWeatherData()
    }

    
    func getWeatherData()
    {
        Alamofire.request(.GET, weatherBaseURL, parameters: ["q": cityTextField.text!, "APPID": "6be1b1956ac65ae6ed8ac3fa17402547", "units": "imperial"]).responseJSON
        { response in
            
            let json = JSON(response.result.value!)
            let a = round(json["main"]["temp"].floatValue).description
            print(a + " json success")

            self.cityLabel.text = json["name"].stringValue
            self.cityTemperatureLabel.text = round(json["main"]["temp"].floatValue).description + "° F"
            self.descriptionLabel.text = json["weather"]["description"].stringValue //description is currently not displaying because of API provider
            self.windLabel.text = round(json["wind"]["speed"].floatValue).description + "mph"
            self.snowLabel.text = json["rain"]["rain.3h"].stringValue + " inches" //snow is currently not displaying because of API provider
            self.pressureLabel.text = round(json["main"]["pressure"].floatValue).description + "hPa"
            self.humidityLabel.text = json["main"]["humidity"].stringValue + "%"
        
        }
    }
    
    
    
    //this function is for hiding the keyboard text when we click outside the textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    
    @IBAction func getCurrentTempButtonTapped(sender: AnyObject)
    {
        
        getWeatherData()
        self.cityTextField.resignFirstResponder() //Unclicks the keyboard
    
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

