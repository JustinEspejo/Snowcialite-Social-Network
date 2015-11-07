

import UIKit
import Parse

class NewsFeedViewController: UIViewController
{
    
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
                                    // Initializations //
    
    
    //storyboard reference variables
    @IBOutlet weak var logOutDidTap: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    
    

    //test newsfeed
    private var testNewsFeed = newsFeedTest.createNewsFeed()
//    let user : User;
    
    //Identifiers
    struct Storyboard
    {
        static let showLoginSegue = "Show Login"
        static let showNextScreen = "showNextScreen"
        static let cellIdentifier = "Newsfeed Cell"
        static let showLoginSequeNoAnimate = "No Animation"
        static let showPost = "Show Post"
        
    }
    
    
    // ---- When viewcontroller loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if PFUser.currentUser() == nil
        {
            
            performSegueWithIdentifier(Storyboard.showLoginSequeNoAnimate, sender: nil)
            
        }

        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let user = User(userLoggedIn: PFUser.currentUser()!)
        
        let imageFile = user.profilePicture
        imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if (error == nil) {
                if let image = UIImage(data:imageData!){
                    dispatch_async(dispatch_get_main_queue()) {
                        self.profilePicButton.setImage(image, forState: .Normal)
                        self.profilePicButton.layer.cornerRadius = self.profilePicButton.frame.size.width/2
                        self.profilePicButton.clipsToBounds = true
                    }}
            }
        })
    }
    
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
                                     // Buttons //
    

    
    @IBAction func logOutDidTap(sender: AnyObject)
    {
        PFUser.logOut()
        self.performSegueWithIdentifier(Storyboard.showLoginSegue, sender: nil)
    }
    
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
                                // Prepare for Segue //
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {

        if segue.identifier == Storyboard.showLoginSegue {
            let loginSignupVC = segue.destinationViewController as! LoginSignupViewController
            loginSignupVC.hidesBottomBarWhenPushed = true
            loginSignupVC.navigationItem.hidesBackButton = true
       
        }
        
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


////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
                              // COLLECTION VIEW SETUP DATA SOURCE//

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


