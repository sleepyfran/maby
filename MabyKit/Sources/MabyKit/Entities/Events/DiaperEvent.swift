import CoreData
import Foundation

/// Represents an event of changing the baby's diaper, which contains the type of diaper that was found.
public final class DiaperEvent: Event {
    @objc public enum DiaperType: Int32, CaseIterable {
        case wet, dirty, mixed, clean
    }
    
    @NSManaged public var type: DiaperType
    
    public convenience init(
        context: NSManagedObjectContext,
        date: Date,
        type: DiaperType
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "DiaperEvent", in: context)!,
            insertInto: context
        )
        self.start = date
        self.type = type
    }
}
