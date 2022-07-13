import CoreData
import Foundation

/// Represents an event of the baby sleeping, which includes the end date.
public final class SleepEvent: Event {
    @NSManaged public var end: Date
}
