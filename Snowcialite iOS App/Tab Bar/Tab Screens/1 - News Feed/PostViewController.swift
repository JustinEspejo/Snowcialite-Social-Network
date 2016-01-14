//
//  PostViewController.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 11/1/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var profilePicButton: UIButton!
    //Outlets
    @IBOutlet weak var tabBar: UIToolbar!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageCaption: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    
    //variables
    var imagePicker = UIImagePickerController()
    let pickedImage = UIImage()
    var imageExist = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        textView?.delegate = self
        textView.text = "How are you feeling?     "
        textView.textColor = UIColor.lightGrayColor()
        imagePicker.delegate = self
        let user = User.sharedInstance()
        user.refreshUser()
        let image = user.profilePicture
        self.profilePicButton.setImage(image, forState: .Normal)
        self.userLabel.text = User.sharedInstance().userName
    }

    
    @IBAction func postButtonPressed(sender: AnyObject)
    {
        if (imageExist){
            let user = PFUser.currentUser()
            let photoPost = PFObject(className:"Images")
            let imageData = UIImageJPEGRepresentation(self.imagePost.image!, 0.5)
            let parseImageFile = PFFile(name: "upload.jpg", data: imageData!)
            photoPost["image"] = parseImageFile
            photoPost["imageCaption"] = imageCaption.text
            photoPost["uploader"] = user
            photoPost.saveInBackgroundWithBlock({ (success, error: NSError?) -> Void in
                if error == nil
                {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                else
                {
                    print(error)
                }
            })
        }
        else if (textView.text == "" || textView.text=="How are you feeling?     ")
        {
            alertNotification("No post", message: "Please enter a status!")
            self.view.endEditing(true)
        }
        else
        {
                let user = PFUser.currentUser()
                // Create the comment
                let post = PFObject(className:"Post")
                post["status"] = textView.text
                post["user"] =  user
                post.saveInBackground()
                textView.text=""
                self.navigationController?.popToRootViewControllerAnimated(true)
        }
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
            } else
            {
                alertNotification("Rear camera does not exist", message: "Cannot access camera")
            }
        } else
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

    func textViewDidBeginEditing(textView: UITextView)
    {
        if textView.textColor == UIColor.lightGrayColor()
        {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if textView.text.isEmpty
        {
            textView.text = "How are you feeling?     "
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBAction func swipeDown(sender: AnyObject)
    {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Notifications
    func keyboardWillShowNotification(notification: NSNotification)
    {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func keyboardWillHideNotification(notification: NSNotification)
    {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification)
    {
        let userInfo = notification.userInfo!
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: animationCurve, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    func alertNotification (title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

extension PostViewController: UIImagePickerControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        let pickedImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage
        imagePicker.dismissViewControllerAnimated(true, completion:
        {
            self.textView.hidden = true
            self.imagePost.hidden = false
            self.imageCaption.hidden = false
            self.imagePost.contentMode = .ScaleAspectFit
            self.imagePost.image = pickedImage
            self.imageExist = true
            User.sharedInstance().didEdit = true
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
        })
    }
}


