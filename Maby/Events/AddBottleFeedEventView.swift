import Factory
import MabyKit
import SwiftUI

struct AddBottleFeedEventView: View {
    @Injected(Container.eventService) private var eventService
    
    @State private var date = Date.now
    @State private var quantity = 100
    
    var body: some View {
        AddEventView(
            "🍼 Bottle feed",
            onAdd: {
                eventService.addBottle(date: date, amount: quantity)
            }
        ) {
            Section("Time") {
                DatePicker(
                    "Start",
                    selection: $date,
                    in: Date.distantPast...Date.now
                )
            }
            
            Section("Amount (mL)") {
                TextField("Amount in milliliters", value: $quantity, format: .number)
                    .keyboardType(.numberPad)
            }
        }
    }
}

struct AddBottleFeedEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddBottleFeedEventView()
    }
}
