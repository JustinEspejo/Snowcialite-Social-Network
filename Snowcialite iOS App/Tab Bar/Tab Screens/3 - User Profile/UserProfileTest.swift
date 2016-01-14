//
//  newsFeedTest.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 10/30/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit

class UserProfileTest
    
{
    
    var title = ""
    var description = ""
    var featuredImage: UIImage!
    
    init(title: String, description: String, featuredImage: UIImage!)
    {
        
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
        
    }
    
    static func createNewsFeed() -> [UserProfileTest]
    {
        return [
            
            UserProfileTest(title: "Snobord is gud sport 😳 😸", description: "rekT the trees today, the woods was GG", featuredImage: UIImage(named: "snobord")!),
            
            UserProfileTest(title: "Denise jumped a few inches today, almost at my level -paolo", description: "I'd give it a 6/10", featuredImage: UIImage(named: "2")!),
            
            UserProfileTest(title: "Today is a good day", description: ":D", featuredImage: UIImage(named: "1")!),
            
            UserProfileTest(title: "Met some cool japanese people in the mountain.", description: "japanese people rock!", featuredImage: UIImage(named: "3")!),
            
            UserProfileTest(title: "shredding with some noobs", description: "gg", featuredImage: UIImage(named: "4")!),
            
        ]
    }
}
