//
//  newsFeedTest.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 10/30/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit

class newsFeedTest

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
    
    static func createNewsFeed() -> [newsFeedTest]
    {
        return [
            
            newsFeedTest(title: "Snobord is gud sport 😳 😸", description: "rekT the trees today, the woods was GG", featuredImage: UIImage(named: "snobord")!),
            
            newsFeedTest(title: "Denise jumped a few inches today, almost at my level -paolo", description: "I'd give it a 6/10", featuredImage: UIImage(named: "2")!),
            
            newsFeedTest(title: "Today is a good day", description: ":D", featuredImage: UIImage(named: "1")!),
            
            newsFeedTest(title: "Met some cool japanese people in the mountain.", description: "japanese people rock!", featuredImage: UIImage(named: "3")!),
            
            newsFeedTest(title: "shredding with some noobs", description: "gg", featuredImage: UIImage(named: "4")!),
        
        
        ]
    
    
    }
    
    
}
