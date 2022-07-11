import Factory
import Foundation

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
}
