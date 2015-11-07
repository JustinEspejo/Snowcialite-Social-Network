//
//  User.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 11/5/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import Foundation
import Parse
class User {

//    static let userInstance = User(userLoggedIn: PFUser.currentUser()!)
    
    var profilePicture : PFFile
    var userName : String
    var userID: String
//    var photo : [UIImage] = []

    
    init(userLoggedIn : PFUser) {
            print ("class initialized")
            let user = userLoggedIn
            self.userID = (PFUser.currentUser()?.objectId)!
            self.userName = user["username"] as! String
          self.profilePicture = user["profilepic"] as! PFFile



//            self.userID = user["objectId"] as! String
//        print(self.userID)
        
        // Assume PFObject *myPost was previously created.
////        // Using PFQuery
//        let query = PFQuery(className: "Images")
//        query.whereKey("uploader", equalTo: PFUser.currentUser()!)
//        query.findObjectsInBackgroundWithBlock {
//            (photoFiles: [PFObject]?, error: NSError?) -> Void in
//            // comments now contains the comments for myPost
//            if photoFiles == nil {
//            print("yuck")
//            }
//            else{
//            for photoFile in photoFiles!
//            {
//                
//                
//                
//            }
//                print(self.photo)
//            }
//
//        }
//
//        

//        }
    }
}
