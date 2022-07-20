import Foundation

/// Formats the given volume measurement.
public func formatMl(amount: Measurement<UnitVolume>) -> String {
    let fmt = MeasurementFormatter()
    fmt.unitOptions = .providedUnit
    fmt.unitStyle = .medium
    return fmt.string(for: amount)!
}
