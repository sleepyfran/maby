import Factory
import MabyKit
import SwiftUI

struct AddSleepEventView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Injected(Container.eventService) private var eventService
    
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    private func onAdd() {
        let result = eventService.addSleep(start: startDate, end: endDate)

        switch(result) {
        case .success(_):
            dismiss()
            return
        case .failure(_):
            return
        }
    }
    
    var body: some View {
        Form {
            Section() {
                Text("🌝 Sleep")
                    .font(.largeTitle)
            }
            .clearBackground()
            
            Section("Time") {
                DatePicker(
                    "Start",
                    selection: $startDate,
                    in: Date.distantPast...Date.now
                )
                DatePicker(
                    "End",
                    selection: $endDate,
                    in: startDate...Date.distantFuture
                )
            }
            
            Button(action: onAdd) {
                Text("Add")
            }
            .buttonStyle(.primaryAction)
            .clearBackground()
        }
    }
}

struct AddSleepEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddSleepEventView()
    }
}
