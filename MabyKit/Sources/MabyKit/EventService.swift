import CoreData
import Logging
import Foundation

public class EventService {
    let database: PersistenceController
    let logger: Logger
    
    init(database: PersistenceController, logger: Logger) {
        self.database = database
        self.logger = logger
    }
    
    private func save<E: Event>(event: E) -> Result<E, AddError> {
        do {
            try database.container.viewContext.save()
            return .success(event)
        } catch(let error) {
            logger.error("Attempted to save database with new event, but failed with reason: \(error)")
            return .failure(.databaseError)
        }
    }
    
    /// Removes the given event from the database.
    public func delete(events: [Event]) {
        events.forEach { event in
            database.container.viewContext.delete(event)
        }
        
        do {
            try database.container.viewContext.save()
        } catch(let error) {
            logger.error("Attempted to remove event, but failed with reason \(error)")
        }
    }
    
    /// Removes **ALL** events from the database.
    public func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Event")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try database.container.viewContext.execute(deleteRequest)
        } catch (let error) {
            logger.error("Attempted to remove ALL events, but failed with reason: \(error)")
        }
    }
    
    /// Adds a new feeding from a bottle.
    public func addBottle(
        date: Date,
        amount: Int
    ) -> Result<BottleFeedEvent, AddError> {
        let event = BottleFeedEvent(
            context: database.container.viewContext,
            date: date,
            quantity: Int32(amount)
        )
        
        return save(event: event)
    }
    
    public func addBottle(amount: Int) -> Result<BottleFeedEvent, AddError> {
        return addBottle(date: Date.now, amount: amount)
    }
    
    /// Adds a new diaper change event to the database.
    public func addDiaperChange(
        date: Date,
        type: DiaperEvent.DiaperType
    ) -> Result<DiaperEvent, AddError> {
        let event = DiaperEvent(
            context: database.container.viewContext,
            date: date,
            type: type
        )
        
        return save(event: event)
    }
    
    public func addDiaperChange(
        type: DiaperEvent.DiaperType
    ) -> Result<DiaperEvent, AddError> {
        return addDiaperChange(date: Date.now, type: type)
    }
    
    /// Adds a new nursing event to the database if the provided dates are valid.
    public func addNursing(
        start: Date,
        end: Date,
        breast: NursingEvent.Breast
    ) -> Result<NursingEvent, AddError> {
        if start > end {
            return .failure(.invalidData)
        }
        
        let event = NursingEvent(
            context: database.container.viewContext,
            start: start,
            end: end,
            breast: breast
        )
        
        return save(event: event)
    }
    
    public func addNursing(
        duration: Double,
        breast: NursingEvent.Breast
    ) -> Result<NursingEvent, AddError> {
        let end = Date.now
        let start = Calendar.current.date(
            byAdding: .minute,
            value: Int(duration.rounded(.up)) * -1,
            to: end
        )!
        
        return addNursing(start: start, end: end, breast: breast)
    }
    
    /// Adds a new sleep event to the database if the provided dates are valid.
    public func addSleep(
        start: Date,
        end: Date
    ) -> Result<SleepEvent, AddError> {
        if start > end {
            return .failure(.invalidData)
        }
        
        let event = SleepEvent(
            context: database.container.viewContext,
            start: start,
            end: end
        )
        
        return save(event: event)
    }
    
    public func addSleep(duration: Double) -> Result<SleepEvent, AddError> {
        let end = Date.now
        let start = Calendar.current.date(
            byAdding: .hour,
            value: Int(duration.rounded(.up)) * -1,
            to: end
        )!
        
        return addSleep(start: start, end: end)
    }
    
    /// Adds a new diaper change event to the database.
    public func addVomit(
        date: Date,
        quantity: VomitEvent.Quantity
    ) -> Result<VomitEvent, AddError> {
        let event = VomitEvent(
            context: database.container.viewContext,
            date: date,
            quantity: quantity
        )
        
        return save(event: event)
    }
    
    public func addVomit(
        quantity: VomitEvent.Quantity
    ) -> Result<VomitEvent, AddError> {
        return addVomit(date: Date.now, quantity: quantity)
    }
}
