import CoreData
import Foundation

/// Represents an event of nursing the baby, which includes and end date.
public final class NursingEvent: Event {
    @NSManaged public var end: Date
    
    public convenience init(
        context: NSManagedObjectContext,
        start: Date,
        end: Date
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "NursingEvent", in: context)!,
            insertInto: context
        )
        self.start = start
        self.end = end
    }
}
