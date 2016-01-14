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
  /*
----------------------VARIABLE INITIALIZATIONS---------------------------------------------------------------
  */
    // User
    private var testUser = UserProfileTest.createNewsFeed()

    //storyboard reference variablesx`
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicViewImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var boardingStyleLabel: UILabel!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var segmentedViewController: UISegmentedControl!
    
    //class variables
    private let leftAndRightPaddings: CGFloat = 32.0
    private let numberofItemsPerRow: CGFloat = 3.0
    private let heightAdjustment: CGFloat = 30.0
    private var imagePicker = UIImagePickerController()
    private var pickedImage = UIImage()
    private var profilePicture = UIImage()
    private var posts = [PFObject]()
    private var status = [String]()
    private var tableViewStatus = [String]()
    private var images = [UIImage]()

    
    struct Storyboard
    {
        static let showLoginSegue = "Show Login 2"
        static let userCollectionViewCell = "User Cell"
        static let cell = "Cell Data"
    }
    
/*
    ----------------------VIEW MAIN FUNCTION ---------------------------------------------------------
*/

    
    override func viewDidLoad()
    {

        super.viewDidLoad()
        imagePicker.delegate = self
        getUserImages()
        userTableView.hidden = true

//        let width = (CGRectGetWidth(userCollectionView!.frame) - leftAndRightPaddings) / numberofItemsPerRow
//        let layout = userCollectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemsize=CGSizeMake(width, width + heightAdjustment)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getUserImages", name: "getPics", object: nil)
//        let userImages = UserImages()

    }
    
    override func viewWillAppear(animated: Bool)
    {
        User.sharedInstance().refreshUser()
        print("GETTING HERE TO BLOCK AND WAIT TILL DATA IS BACK")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateProfilePicture", name: "profilePictureReceived", object: nil)
        print("GETTING HERE TO BLOCK AND WAIT TILL POSTS IS BACK")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTableValues", name: "getPosts", object: nil)
        updatePosts()
        if(User.sharedInstance().didEdit){
        getUserImages()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
/*
    ---------------------- GET AND UPDATE DATA---------------------------------------------------------
*/

    
    func getUserImages()
    {
        if(User.sharedInstance().didEdit == true){
            print("I EDITED")
            self.images = []
            User.sharedInstance().didEdit = false }
        let postsQuery = PFQuery(className:"Images")
        postsQuery.whereKey("uploader", equalTo: PFUser.currentUser()!)
        postsQuery.orderByDescending("createdAt")
        postsQuery.findObjectsInBackgroundWithBlock { (status, error) -> Void in
            if  error == nil
            {
                for object in status! {
                    
                    let imageFile = object["image"] as! PFFile
                    print("this is the file", imageFile)
                    imageFile.getDataInBackgroundWithBlock(
                        { (imageData, error) -> Void in
                            if (error == nil)
                            {
                                if let image = UIImage(data:imageData!)
                                {
                                    self.images.append(image)
                                    print("this is the IMAGE",image)
                                    print("I'M GIVING YOU THE PICS, GO ON WITH YOUR THING")
                                    self.userCollectionView.reloadData()
                                }
                            }
                            
                    })
                    
                }
                
                
            }
            else
            {
                
            }
            
            
        }
        
    }

    @IBAction func segmentedViewControlPressed(sender: UISegmentedControl) {
        
        switch segmentedViewController.selectedSegmentIndex
        {
        case 0:
            userCollectionView.hidden = false
            userTableView.hidden = true
            
        case 1:
            userCollectionView.hidden = true
            userTableView.hidden = false
        
        default:
            break;
        }
    }
    
    
    func updateProfilePicture()
    {
        let image = User.sharedInstance().profilePicture
        self.profilePicViewImage.image = image
        var userNameString = User.sharedInstance().userName
        userNameLabel.text = userNameString
        userNameString += " photo's"
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "profilePictureReceived", object: nil)
        print("Thanks for the data, I'm FREE")

    }
    
    func updatePosts()
    {
        let postsQuery = PFQuery(className:"Post")
        postsQuery.whereKey("user", equalTo: PFUser.currentUser()!)
        postsQuery.orderByDescending("createdAt")
        postsQuery.findObjectsInBackgroundWithBlock { (status, error) -> Void in
            if  error == nil
            {
                self.posts = status! as [PFObject]
                for object in status! {
                    let theStatus = object["status"] as! String
                    self.status.append(theStatus)
                }
                print("I'M GIVING YOU THE POSTS, GO ON SON")
                NSNotificationCenter.defaultCenter().postNotificationName("getPosts", object: self)
            }
            else
            {
                
            }
        }
    }
    
    func updateTableValues()
    {
        print("Thanks for the posts!!")
        tableViewStatus = self.status
        userTableView.backgroundView = nil
        userTableView.backgroundColor = UIColor.clearColor()
        userTableView.reloadData()
        self.status.removeAll()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "getPosts", object: nil)
        
    }
    
    func clear()
    {
        self.tableViewStatus = []
        self.userTableView.reloadData()
        self.images = []
        self.userCollectionView.reloadData()
    }
    
/*
    ---------------------- BUTTON ACTIONS ---------------------------------------------------------
*/
    
    
    @IBAction func logOutDidTap(sender: AnyObject)
    {
            self.clear()
            User.sharedInstance().clearUser()
            PFUser.logOut()
            self.performSegueWithIdentifier(Storyboard.showLoginSegue, sender: nil)
    }
    
    @IBAction func cameraButtonTapped(sender: AnyObject)
    {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera))
        {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil
            {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            }
            else
            {
                alertNotification("Rear camera does not exist", message: "Cannot access camera")
            }
        }
        else
        {
            alertNotification("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }

    @IBAction func mediaButtonTapped(sender: AnyObject)
    {
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

/*
-------------------- IMAGE PICKER DELEGATES ---------------------------------------------------------------
*/

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
                        self.profilePicViewImage.image = self.pickedImage
                        User.sharedInstance().didEdit = true
                    }
                    else
                    {
                        print(error)
                    }
                })
        })
    }

    
    // backed out and canceled upload
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
        })
    }
    

 
    
}
   
/*
-------------------------------COLLECTION VIEW DATA SOURCE EXTENSIONS--------------------------------------
*/

    extension UserProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    //initialize sections
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    //initialize rows
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.userCollectionViewCell, forIndexPath: indexPath) as! UserCollectionViewCell
            //print("this is the image", images[indexPath.item])
            cell.featuredImageView.image = self.images[indexPath.item]
            return cell
    }
        
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
     
    
        performSegueWithIdentifier(Storyboard.cell, sender: nil)
        
    }
        
    
    
}

/*
-------------------------------TABLE DATA SOURCE EXTENSIONS--------------------------------------
*/

extension UserProfileViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSectionsInTableView(userTableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(userTableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewStatus.count
    }
    
    func tableView(userTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.text = tableViewStatus[indexPath.row]
        return cell
    }
    
}
