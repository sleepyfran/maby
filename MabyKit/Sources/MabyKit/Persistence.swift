import CoreData

public struct PersistenceController {
    public static let shared = PersistenceController()

    public static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let babyJohn = Baby(
            context: viewContext,
            name: "John",
            birthday: Calendar.current.date(byAdding: .month, value: -2, to: Date.now)!,
            gender: Baby.Gender.boy
        )
        
        let babyCassandra = Baby(
            context: viewContext,
            name: "Cassandra",
            birthday: Calendar.current.date(byAdding: .day, value: -23, to: Date.now)!,
            gender: Baby.Gender.girl
        )
        
        let nursingEvent = NursingEvent(
            context: viewContext,
            start: Calendar.current.date(byAdding: .minute, value: -48, to: Date.now)!,
            end: Calendar.current.date(byAdding: .minute, value: -24, to: Date.now)!,
            breast: .left
        )
        
        let sleepEvent = SleepEvent(
            context: viewContext,
            start: Calendar.current.date(byAdding: .hour, value: -1, to: Date.now)!,
            end: Date.now
        )
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        guard
            let objectModelURL = Bundle.module.url(forResource: "Maby", withExtension: "momd"),
            let objectModel = NSManagedObjectModel(contentsOf: objectModelURL)
        else {
            fatalError("Failed to retrieve the object model")
        }
        
        container = NSPersistentCloudKitContainer(name: "Maby", managedObjectModel: objectModel)
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
