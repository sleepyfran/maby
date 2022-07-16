import Factory
import MabyKit
import SwiftUI

struct AddVomitEventView: View {
    @Injected(Container.eventService) private var eventService
    
    @State private var date = Date.now
    @State private var quantity = VomitEvent.Quantity.little
    
    var body: some View {
        AddEventView(
            "🤢 Vomit",
            onAdd: { eventService.addVomit(date: date, quantity: quantity) }
        ) {
            DatePicker("Date", selection: $date)
            
            Section("Quantity") {
                Picker("Quantity", selection: $quantity) {
                    Text("Little").tag(VomitEvent.Quantity.little)
                    Text("Medium").tag(VomitEvent.Quantity.medium)
                    Text("Big").tag(VomitEvent.Quantity.big)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

struct AddVomitEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddVomitEventView()
    }
}
