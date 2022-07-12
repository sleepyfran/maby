import Foundation

/// Error that can happen while attempting to add a new entity to the database.
public enum AddError: Error {
    case invalidData, databaseError
}
