import Logging
import Foundation

/// Returns whether the given parameters constitue a valid baby entry or not.
public func isValidBaby(name: String, birthday: Date) -> Bool {
    !name.isEmpty && birthday < Date.now
}

public class BabyService {
    let database: PersistenceController
    let logger: Logger
    
    init(database: PersistenceController, logger: Logger) {
        self.database = database
        self.logger = logger
    }
    
    /// Adds a new baby to the database, checking that the parameters are correct.
    public func add(
        name: String,
        birthday: Date,
        gender: Baby.Gender
    ) -> Result<Baby, AddError> {
        if (!isValidBaby(name: name, birthday: birthday)) {
            return .failure(.invalidData)
        }
        
        let baby = Baby(
            context: database.container.viewContext,
            name: name,
            birthday: birthday,
            gender: gender
        )
        
        do {
            try database.container.viewContext.save()
            return .success(baby)
        } catch(let error) {
            logger.error("Attempted to save database with new baby, but failed with reason: \(error)")
            return .failure(.databaseError)
        }
    }
}