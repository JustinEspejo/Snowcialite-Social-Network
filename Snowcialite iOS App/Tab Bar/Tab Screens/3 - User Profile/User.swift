//
//  User.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 11/5/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import Foundation
import Parse

var instance: User?

public class User: NSObject
{
//  static let userInstance = User(userLoggedIn: PFUser.currentUser()!)
    var userName = String()
    var userID = String()
    var profilePicture = UIImage()
    var didEdit = false
    
    public class func sharedInstance() -> User
    {
        if !(instance != nil)
        {
            instance = User()
        }
        return instance!
    }
    
    func clearUser()
    {
        self.userID = ""
        self.userName = ""
        self.profilePicture = (UIImage(named: "mario"))!
        self.didEdit = true
    }
    
    func refreshUser()
    {
        let user = PFUser.currentUser()!
        self.userID = (PFUser.currentUser()?.objectId)!
        self.userName = user["username"] as! String
        let imageFile = (user["profilepic"] as! PFFile)
        imageFile.getDataInBackgroundWithBlock(
        { (imageData, error) -> Void in
            if (error == nil)
            {
                if let image = UIImage(data:imageData!)
                {
                    self.profilePicture = image
                    print("I'M GIVING YOU THE DATA.")
                      NSNotificationCenter.defaultCenter().postNotificationName("profilePictureReceived", object: self)
                    
                }
            }
        })
    }
}
