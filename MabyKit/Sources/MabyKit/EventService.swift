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
}
