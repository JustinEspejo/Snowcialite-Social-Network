//
//  Created by Justin Espejo on 11/12/15.
//  Copyright © 2016 Snowcialite. All rights reserved.
//

import Foundation
import CoreData

class Run: NSManagedObject {

    @NSManaged var duration: NSNumber
    @NSManaged var distance: NSNumber
    @NSManaged var timestamp: NSDate
    @NSManaged var locations: NSOrderedSet

}
