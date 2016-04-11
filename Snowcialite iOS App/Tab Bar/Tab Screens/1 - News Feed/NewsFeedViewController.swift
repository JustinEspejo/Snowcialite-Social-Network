//
//  Created by Justin Espejo on 11/12/15.
//  Copyright © 2016 Snowcialite. All rights reserved.
//

import UIKit
import Parse

class NewsFeedViewController: UIViewController
{
    /*
    ----------------------VARIABLE INITIALIZATIONS---------------------------------------------------------------
    */
    //storyboard reference variables
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    

    //test newsfeed
    private var testNewsFeed = newsFeedTest.createNewsFeed()
    
    
    //Identifiers
    struct Storyboard
    {
        static let showNextScreen = "showNextScreen"
        static let cellIdentifier = "Newsfeed Cell"
        static let showLoginSequeNoAnimate = "No Animation"
        static let showPost = "Show Post"
        static let showUserProfile = "Show User Profile"
    }
    
/*
----------------------VIEW MAIN FUNCTION ---------------------------------------------------------------
*/
    
    // ---- When viewcontroller loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier(Storyboard.showLoginSequeNoAnimate, sender: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController!.navigationBarHidden = false;
        User.sharedInstance().refreshUser()
        print("GETTING HERE TO BLOCK AND WAIT")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateProfilePicture", name: "profilePictureReceived", object: nil)
        
    }
    


/*
---------------------- UPDATE DATA FUNCTIONS ---------------------------------------------------------------
*/
    
    
    @IBAction func userProfilePictureDidTap(sender: AnyObject)
    {
    
    self.tabBarController?.selectedIndex = 2
        
    }
    
    
    func updateProfilePicture()
    {
        let image = User.sharedInstance().profilePicture
        self.profilePicButton.setImage(image, forState: .Normal)
        self.profilePicButton.layer.cornerRadius = self.profilePicButton.frame.size.width/2
        self.profilePicButton.clipsToBounds = true
        print("Thanks for the Data. ")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "profilePictureReceived", object: nil)
    }
    


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == Storyboard.showLoginSequeNoAnimate {
            let loginSignupVC = segue.destinationViewController as! LoginSignupViewController
            loginSignupVC.hidesBottomBarWhenPushed = true
            loginSignupVC.navigationItem.hidesBackButton = true
        }
        
        if segue.identifier == Storyboard.showPost {
            let postVC = segue.destinationViewController as! PostViewController
            postVC.hidesBottomBarWhenPushed = true
            
        }
    
    }

}

/*
---------------------- COLLECTION VIEW DATA SOURCE ---------------------------------------------------------------
*/


extension NewsFeedViewController: UICollectionViewDataSource
{
    //initialize sections
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }

    //initialize rows
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return testNewsFeed.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.cellIdentifier, forIndexPath: indexPath) as! newsFeedCollectionViewCell
        cell.newsFeed = testNewsFeed[indexPath.item]
        return cell
    }
    
}


