//
//  Created by Justin Espejo on 11/12/15.
//  Copyright © 2016 Snowcialite. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import AVKit
import AVFoundation

class LoginSignupViewController: PFLogInViewController
{
//    var player: AVPlayer?
    
    var initialOpening = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(initialOpening == true){
            performSegueWithIdentifier("initial screen", sender: nil)
        }
        title = "Snowcialite Login"
        let signupVC = PFSignUpViewController()
        signupVC.delegate = self
        self.signUpController = signupVC
        self.delegate = self
        
        logInView?.logo = UIImageView(image: UIImage(named: "logo")!)
        logInView?.backgroundColor = (UIColor .whiteColor())
        signupVC.signUpView?.logo = UIImageView(image: UIImage(named: "logo")!)
        signupVC.signUpView?.backgroundColor = (UIColor .whiteColor())
//        setupVideoBackground()
    }
    

    func shownewsFeed()
    {
//        User.sharedInstance().refreshUser()
        print("login/signup success")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    func signUpUserDefaults()
    {
        dismissViewControllerAnimated(true, completion: nil)
        let user = PFUser.currentUser()
        let image : UIImage = UIImage(named:"mario")!
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        let parseImageFile = PFFile(name: "upload.jpg", data: imageData!)
        user!["profilepic"] = parseImageFile
        user!.saveInBackgroundWithBlock({ (success, error: NSError?) -> Void in
            if error == nil
            {
                print("Sign up success")
            }
            else
            {
                print(error)
            }
        })
    
    }
        
}


extension LoginSignupViewController : PFSignUpViewControllerDelegate
{
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
    {
        signUpUserDefaults()
        shownewsFeed()
    }
}
extension LoginSignupViewController : PFLogInViewControllerDelegate
{
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
    {
        shownewsFeed()
    }
}
