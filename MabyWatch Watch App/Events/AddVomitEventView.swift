import Factory
import MabyKit
import SwiftUI

struct AddVomitEventView: View {
    @Injected(Container.eventService) private var eventService
    
    @State private var quantity = VomitEvent.Quantity.little
    
    var body: some View {
        AddEventView(action: {
            eventService.addVomit(quantity: quantity)
        }) {
            Picker("Quantity", selection: $quantity) {
                Text("Little").tag(VomitEvent.Quantity.little)
                Text("Medium").tag(VomitEvent.Quantity.medium)
                Text("Big").tag(VomitEvent.Quantity.big)
            }
            .pickerStyle(.inline)
        }
        .navigationBarTitle("🤢 Vomit")
    }
}

struct AddVomitEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddVomitEventView()
    }
}
