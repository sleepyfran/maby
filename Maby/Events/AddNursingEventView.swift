import Factory
import MabyKit
import SwiftUI

struct AddNursingEventView: View {
    @Injected(Container.eventService) private var eventService
    
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    @State private var breast = NursingEvent.Breast.left
    
    var body: some View {
        AddEventView(
            "🤱 Nursing",
            onAdd: {
                eventService.addNursing(
                    start: startDate,
                    end: endDate,
                    breast: breast
                )
            }
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
            
            Section("Breast") {
                Picker("Breast", selection: $breast) {
                    Text("Left").tag(NursingEvent.Breast.left)
                    Text("Right").tag(NursingEvent.Breast.right)
                    Text("Both").tag(NursingEvent.Breast.both)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

struct AddNursingEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddNursingEventView()
    }
}
