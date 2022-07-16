import Factory
import MabyKit
import SwiftUI

struct AddSleepEventView: View {
    @Injected(Container.eventService) private var eventService
    
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    var body: some View {
        AddEventView(
            "🌝 Sleep",
            onAdd: { eventService.addSleep(start: startDate, end: endDate) }
        ) {
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
        }
    }
}

struct AddSleepEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddSleepEventView()
    }
}
