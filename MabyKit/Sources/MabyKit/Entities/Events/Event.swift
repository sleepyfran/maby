import CoreData
import Foundation

/// Represents the types of events that we currently support. These are not used in the models, but are
/// just an easy way to represent them in the UI and this package without instantiating an actual sub-class
/// of the event.
public enum EventType {
    case bottle, diaper, nursing, sleep, vomit
}

/// Represents an event with its start date. Do not use this entity directly, instead use one of the specific
/// events since that's the way they'll be retrieved.
public class Event: NSManagedObject, Identifiable {
    @NSManaged public var start: Date
    
    /// Returns the start date without any time to properly group it.
    @objc public var groupStart: Date {
        let components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: self.start
        )
        return Calendar.current.date(from: components)!
    }
}
