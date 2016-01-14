//
//  UserImages.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 11/13/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import Foundation
import Parse

class UserImages {
    
    var profilePictureObject = [PFObject]()
    var profilePicture = [UIImage]()
//    var profilePictureFile :PFFile()
    
    
    init()
    {
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
                                    self.profilePicture.append(image)
                                    print("this is the pregnaant",image)
                                    print("I'M GIVING YOU THE NEKKID PICS MOTHA FUCKA, GO ON WITH YOUR SHIT")
                                }
                            }
                            NSNotificationCenter.defaultCenter().postNotificationName("getPics", object: self)

                    })

                }


            }
            else
            {
                
            }
            

        }

    }
    
    func refresh()
    {
        let postsQuery = PFQuery(className:"Images")
        postsQuery.whereKey("uploader", equalTo: PFUser.currentUser()!)
        postsQuery.orderByDescending("createdAt")
        postsQuery.findObjectsInBackgroundWithBlock { (status, error) -> Void in
            if  error == nil
            {
                self.profilePictureObject = status! as [PFObject]
                for object in status! {
                    let imageFile = object["image"] as! PFFile
                    print("this is the file", imageFile)
                    imageFile.getDataInBackgroundWithBlock(
                        { (imageData, error) -> Void in
                            if (error == nil)
                            {
                                if let image = UIImage(data:imageData!)
                                {
                                    self.profilePicture.append(image)
                                    print("this is the pregnaant",image)
                                    print("I'M GIVING YOU THE NEKKID PICS MOTHA FUCKA, GO ON WITH YOUR SHIT")
                                    NSNotificationCenter.defaultCenter().postNotificationName("getPics", object: self)

                                }
                    }
                    })
                    NSNotificationCenter.defaultCenter().removeObserver(self, name: "getPics", object: nil)

                }
                
            }
            else
            {
                
            }
            
            
        }
    }
}