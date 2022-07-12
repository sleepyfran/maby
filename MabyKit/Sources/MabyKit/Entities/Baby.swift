import CoreData
import Foundation

/// Represents a baby that was added to the app, which is the main entity to which the rest of entities are
/// related to.
public final class Baby: NSManagedObject, Identifiable {
    @objc public enum Gender: Int32, CaseIterable {
        case boy, girl, other
    }
    
    @NSManaged public var name: String
    @NSManaged public var birthday: Date
    @NSManaged public var gender: Gender
    
    public convenience init(
        context: NSManagedObjectContext,
        name: String,
        birthday: Date,
        gender: Gender
    ) {
        self.init(
            entity: NSEntityDescription.entity(forEntityName: "Baby", in: context)!,
            insertInto: context
        )
        self.name = name
        self.birthday = birthday
        self.gender = gender
    }
}
