import CoreData
import Foundation

/// Returns a fetch request that gather all babies in the database, sorted by name.
public var allBabies: NSFetchRequest<Baby> {
    let request = Baby.fetchRequest() as! NSFetchRequest<Baby>
    request.sortDescriptors = [
        NSSortDescriptor(keyPath: \Baby.name, ascending: true)
    ]
    return request
}
