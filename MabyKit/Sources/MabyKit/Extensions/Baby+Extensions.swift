import Foundation

extension Baby {
    public enum Age {
        case days(Int), weeks(Int), months(Int), years(Int)
        
        public var text: String {
            switch self {
            case .years(let years):
                return "\(years) years old"
            case .months(let months):
                return "\(months) months old"
            case .weeks(let weeks):
                return "\(weeks) weeks old"
            case .days(let days):
                return "\(days) days old"
            }
        }
    }
    
    /// Returns the age of the baby in days if the baby is less than a week old, weeks if the baby is less
    /// than a month old, months if the baby is less than a year old and years for the rest of the cases.
    public var age: Age {
        let ageDifference = Calendar.current.dateComponents(
            [.day, .weekOfMonth, .month, .year],
            from: birthday,
            to: Date.now
        )
        
        let years = ageDifference.year ?? 0
        let months = ageDifference.month ?? 0
        let weeks = ageDifference.weekOfMonth ?? 0
        let days = ageDifference.day ?? 0
        
        if days <= 7 {
            return .days(days)
        } else if weeks <= 4 {
            return .weeks(weeks)
        } else if months < 12 {
            return .months(months)
        } else {
            return .years(years)
        }
    }
}
