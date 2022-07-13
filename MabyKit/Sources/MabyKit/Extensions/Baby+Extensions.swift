import Foundation

extension Baby {
    /// Returns the formatted age by showing the years, months, weeks and days since the baby was born
    /// but returning only the fields that are more than zero.
    public var formattedAge: String {
        return (self.birthday ..< Date.now).formatted(
            .components(style: .wide, fields: [.year, .month, .week, .day])
        )
    }
}

