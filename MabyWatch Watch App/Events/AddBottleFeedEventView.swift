import Factory
import MabyKit
import SwiftUI

struct AddBottleFeedEventView: View {
    @Injected(Container.eventService) private var eventService
    @Environment(\.dismiss) private var dismiss
    
    @State private var amount = 100.0
    
    private var formattedAmount: String {
        let amountWithMeasurement = Measurement(
            value: amount,
            unit: UnitVolume.milliliters
        )
        
        return formatMl(amount: amountWithMeasurement)
    }
    
    var body: some View {
        AddEventView(action: {
            eventService.addBottle(amount: Int(amount.rounded(.up)))
        }) {
            Section("Amount") {
                VStack(alignment: .leading) {
                    Text(formattedAmount)
                    
                    Slider(value: $amount, in: 0...1000, step: 50) {
                        Text("Amount")
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("🍼 Bottle")
    }
}

struct AddBottleFeedEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBottleFeedEventView()
        }
    }
}
