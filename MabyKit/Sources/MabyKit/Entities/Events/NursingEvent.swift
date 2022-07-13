import CoreData
import Foundation

/// Represents an event of nursing the baby, which includes and end date.
public final class NursingEvent: Event {
    @NSManaged public var end: Date
}
