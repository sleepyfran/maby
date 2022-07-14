import CoreData
import Foundation

/// Represents an event of the baby sleeping, which includes the end date.
public final class SleepEvent: Event {
    @NSManaged public var end: Date
    
    public convenience init(
        context: NSManagedObjectContext,
        start: Date,
        end: Date
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "SleepEvent", in: context)!,
            insertInto: context
        )
        self.start = start
        self.end = end
    }
}
