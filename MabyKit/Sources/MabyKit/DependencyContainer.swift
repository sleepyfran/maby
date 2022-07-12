import Factory
import Foundation
import Logging

extension Container {
    // MARK: - Database & data related stuff
    public static let database = Factory(scope: .singleton) {
        PersistenceController.shared
    }
    
    public static let container = Factory(scope: .singleton) {
        database().container
    }
    
#if DEBUG
    public static let previewContainer = Factory(scope: .singleton) {
        PersistenceController.preview.container
    }
#endif
    
    // MARK: - Services
    public static let babyService = Factory {
        BabyService(database: database(), logger: logger())
    }
    
    // MARK: - Utilities
    public static let logger = Factory {
        Logger(label: "Maby")
    }
}
