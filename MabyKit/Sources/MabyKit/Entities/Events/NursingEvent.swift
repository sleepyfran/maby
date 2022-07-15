import CoreData
import Foundation

/// Represents an event of nursing the baby, which includes and end date.
public final class NursingEvent: Event {
    @objc public enum Breast: Int32, CaseIterable {
        case left, right, both
    }
    
    @NSManaged public var end: Date
    @NSManaged public var breast: Breast
    
    public convenience init(
        context: NSManagedObjectContext,
        start: Date,
        end: Date,
        breast: Breast
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "NursingEvent", in: context)!,
            insertInto: context
        )
        self.start = start
        self.end = end
        self.breast = breast
    }
}
