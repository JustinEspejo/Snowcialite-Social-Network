

import UIKit
import Parse
import ParseUI

class LoginSignupViewController: PFLogInViewController
{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Snowcialite Login"
        
        //----------------signup
        //This shit is for ths signup Viewcontroller so we dont need to initialize another class for it for another view controller
        let signupVC = PFSignUpViewController() //initialize a new signupviewcontroller without making another whole different class for it. (side bitch)
        signupVC.delegate = self
        self.signUpController = signupVC //so we can edit our signupVC
        
        //----------------login
        //This one is for delegating the bottom shit (loginviewcontroller method to work here)
        //shit will not do anything after sign in if u dont put this shit as the delegate
        self.delegate = self

        
        //change the login of parse to our own sexy ass login logo bitches
        logInView?.logo = UIImageView(image: UIImage(named: "logo")!)
        logInView?.backgroundColor = (UIColor .whiteColor())
       // logInView?.logo?.contentMode = .ScaleAspectFill
        
        //change the login logo of signup page
        signupVC.signUpView?.logo = UIImageView(image: UIImage(named: "logo")!)
        signupVC.signUpView?.backgroundColor = (UIColor .whiteColor())

        
    }
    
    func shownewsFeed()
    {
        //pop the login stack off (like how i pop my bitches)
        print("login/signup success")
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension LoginSignupViewController : PFSignUpViewControllerDelegate
{
    //if signup is successful, login the user and go to homepage
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
    {
        dismissViewControllerAnimated(true, completion: nil) //since i poped the fuckin sign up i need this too because the shownewsfeed only pops the first shit under this stack
        print("Sign up success")
        shownewsFeed()
    }
}

//if login is successful, login the user and go to homepage

extension LoginSignupViewController : PFLogInViewControllerDelegate
{

    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
    {
        shownewsFeed()
    }
//commit
}









