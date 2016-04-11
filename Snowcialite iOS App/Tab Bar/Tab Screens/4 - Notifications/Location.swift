//
//  Created by Justin Espejo on 11/12/15.
//  Copyright © 2016 Snowcialite. All rights reserved.
//
import Foundation
import CoreData

class Location: NSManagedObject {
    
    @NSManaged var timestamp: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var relationship: NSOrderedSet?
    @NSManaged var run: NSManagedObject

}
