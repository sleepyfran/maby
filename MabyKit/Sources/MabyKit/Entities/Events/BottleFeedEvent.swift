import CoreData
import Foundation

/// Represents an event of feeding the baby via a bottle or other non-nursing means.
public final class BottleFeedEvent: Event {
    public typealias MlQuantity = Int32
    
    @NSManaged public var quantity: MlQuantity
    
    public convenience init(
        context: NSManagedObjectContext,
        date: Date,
        quantity: MlQuantity
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "BottleFeedEvent", in: context)!,
            insertInto: context
        )
        self.start = date
        self.quantity = quantity
    }
}
