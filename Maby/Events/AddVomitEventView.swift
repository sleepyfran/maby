import Factory
import MabyKit
import SwiftUI

struct AddVomitEventView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Injected(Container.eventService) private var eventService
    
    @State private var date = Date.now
    @State private var quantity = VomitEvent.Quantity.little
    
    private func onAdd() {
        let result = eventService.addVomit(date: date, quantity: quantity)
        
        switch(result) {
        case .success(_):
            dismiss()
            return
        case .failure(_):
            return
        }
    }
    
    var body: some View {
        AddEventView("🤢 Vomit", onAdd: onAdd) {
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
