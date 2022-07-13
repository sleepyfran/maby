import CoreData
import Foundation

/// Represents an event with its start date. Do not use this entity directly, instead use one of the specific
/// events since that's the way they'll be retrieved.
public class Event: NSManagedObject, Identifiable {
    @NSManaged public var start: Date
}
