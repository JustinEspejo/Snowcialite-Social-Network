//
//  UserProfileViewController.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 10/4/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Parse

class UserProfileViewController: UIViewController, UINavigationControllerDelegate
    
{
    //storyboard reference variables
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicViewImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var boardingStyleLabel: UILabel!
    @IBOutlet weak var userCollectionViewCell: UICollectionView!
    
    //class variables
    var imagePicker = UIImagePickerController()
    var pickedImage = UIImage()
    var profilePicture = UIImage()
    
    struct Storyboard {
    
        static let showLoginSegue = "Show Login 2"
        static let userCollectionViewCell = "User Cell"
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imagePicker.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        getProfilePicture ()

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //----------CAMERA BUTTON PRESSED----------//
    //----------------------------------------//
    
    func getProfilePicture (){
        
        let user = User(userLoggedIn: PFUser.currentUser()!)
        
        userNameLabel.text = user.userName
        
            if PFUser.currentUser() != nil{
                let imageFile = user.profilePicture
                imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
                    if (error == nil) {
                        if let image = UIImage(data:imageData!){
                            dispatch_async(dispatch_get_main_queue()) {
                            self.profilePicViewImage.image = image
                            }}
                    }
                })
        }
        
        }
    
    @IBAction func logOutDidTap(sender: AnyObject)
    {
        PFUser.logOut()
        self.performSegueWithIdentifier(Storyboard.showLoginSegue, sender: nil)
        
    }
    
    
    @IBAction func cameraButtonTapped(sender: AnyObject) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera))
        {
            
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil
            {
                
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
                
                
            } else
                
            {
                alertNotification("Rear camera does not exist", message: "Cannot access camera")
            }
        } else
            
        {
            alertNotification("Camera inaccessable", message: "Application cannot access the camera.")
        }
        
    }

    
    
    //----------MEDIA BUTTON PRESSED----------//
    //----------------------------------------//
    @IBAction func mediaButtonTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func alertNotification (title: String, message: String)
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        
        if segue.identifier == Storyboard.showLoginSegue {
            let loginSignupVC = segue.destinationViewController as! LoginSignupViewController
            loginSignupVC.hidesBottomBarWhenPushed = true
            loginSignupVC.navigationItem.hidesBackButton = true
            
        }
        
    }
    
}


extension UserProfileViewController: UIImagePickerControllerDelegate
    
{
    //Did finish picking / taking a picture
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        pickedImage = ((info[UIImagePickerControllerOriginalImage]) as? UIImage)!
        imagePicker.dismissViewControllerAnimated(true, completion:
            {
               
                let user = PFUser.currentUser()
                let imageData = UIImageJPEGRepresentation(self.pickedImage, 0.5)
                let parseImageFile = PFFile(name: "upload.jpg", data: imageData!)
                user!["profilepic"] = parseImageFile
                user!.saveInBackgroundWithBlock({ (success, error: NSError?) -> Void in
                    if error == nil {
                        
//                        dont need this if getprofile works correctly
                        dispatch_async(dispatch_get_main_queue()) {
                    
                            self.profilePicViewImage.image = self.pickedImage
                            
                        }
                    }
                    else
                    {
                        print(error)
                    }
                    
                    }
                )
        })
    }
    

    // Pussied out and canceled upload
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            //if we want to do extra shit
        })
    }
    
    
}
//
//    extension UserProfileViewController: UICollectionViewDataSource
//        
//    {
//        //initialize sections
//        func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//        {
//            return 1
//        }
//        
//        //initialize rows
//        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//        {
//            return 10
//        }
//        
//        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//        {
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.userCollectionViewCell, forIndexPath: indexPath) as! newsFeedCollectionViewCell
//            
//           // cell.newsFeed = testNewsFeed[indexPath.item]
//            
//            
//            return cell
//        }
//        
//    }






