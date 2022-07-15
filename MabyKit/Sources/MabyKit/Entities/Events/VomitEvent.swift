import CoreData
import Foundation

/// Represents an event of the baby vomiting, which includes the amount.
public final class VomitEvent: Event {
    @objc public enum Quantity: Int32, CaseIterable {
        case little, medium, big
    }
    
    @NSManaged public var quantity: Quantity
    
    public convenience init(
        context: NSManagedObjectContext,
        date: Date,
        quantity: Quantity
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "VomitEvent", in: context)!,
            insertInto: context
        )
        self.start = date
        self.quantity = quantity
    }
}
