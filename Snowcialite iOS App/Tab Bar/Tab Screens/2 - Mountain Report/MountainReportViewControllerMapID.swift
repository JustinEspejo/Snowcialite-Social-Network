
//Use this for when a better API is found for trail conditions


import UIKit
import Alamofire
import SwiftyJSON

class MountainReportViewControllerMAPID: UIViewController, UITextFieldDelegate
{
    //storyboard reference variables
    @IBOutlet weak var getCurrentTempButton: UIButton!
    @IBOutlet weak var mountainTextField: UITextField!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var operatingLabel: UILabel!
    @IBOutlet weak var terrainParkLabel: UILabel!
    @IBOutlet weak var nightSkiingLabel: UILabel!
    @IBOutlet weak var lattitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var mountainLabel: UILabel!
    @IBOutlet weak var viewLabel: UIView!
    //class variables
    var weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    var skiMapURL = "https://skimap.org/SkiAreas/view/"

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mountainTextField.delegate = self
        
        getWeatherData()
        
        //why doesn't this work
        viewLabel.layer.cornerRadius = 20
        viewLabel.clipsToBounds = true

    }

    
    func getWeatherData()
    {
        print(mountainTextField.text!)
        //["q": mountainTextField.text!, "APPID": "6be1b1956ac65ae6ed8ac3fa17402547", "units": "imperial"]
        if mountainTextField.text! != ""
        {
        Alamofire.request(.GET, skiMapURL + mountainTextField.text!  + ".json", parameters: nil).responseJSON
        { response in
            
            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.result)   // result of response serialization
            
            let json = JSON(response.result.value!)
//            let a = round(json["main"]["temp"].floatValue).description
//            print(a + " json success")

            self.mountainLabel.text = json["name"].stringValue
//            self.websiteLabel.text = round(json["main"]["temp"].floatValue).description + "° F"
            self.websiteLabel.text = json["official_website"].stringValue

            self.operatingLabel.text = json["operating_status"].stringValue
            self.terrainParkLabel.text = json["terrain_park"].stringValue
            self.nightSkiingLabel.text = json["night_skiing"].stringValue
            self.lattitudeLabel.text = json["latitude"].stringValue
            self.longitudeLabel.text = json["longitude"].stringValue
        
            
        }
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
        self.mountainTextField.resignFirstResponder() //Unclicks the keyboard

    
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
    


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "viewMap"
        {
            let vc = segue.destinationViewController as! MapViewController
//            vc.longitude = Double(longitudeLabel.text!)
//            vc.latitude = Double(lattitudeLabel.text!)
        }
    }
    
}

