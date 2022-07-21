import Factory
import CoreData
import Foundation

/// Returns a fetch request that retrieves the latest event of a given type, sorted by its start date.
public func lastEvent<E: Event>() -> NSFetchRequest<E> {
    let request = E.fetchRequest() as! NSFetchRequest<E>
    request.sortDescriptors = [
        NSSortDescriptor(keyPath: \Event.start, ascending: false)
    ]
    request.fetchLimit = 1
    return request
}
