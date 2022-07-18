import Factory
import MabyKit
import SwiftUI

struct AddSleepEventView: View {
    @Injected(Container.eventService) private var eventService
    
    @State private var duration = 3.0
    
    private var formattedDuration: String {
        duration.formatted(.number.rounded(rule: .up))
    }
    
    var body: some View {
        AddEventView(action: {
            eventService.addSleep(duration: duration)
        }) {
            Section("Duration") {
                VStack(alignment: .leading) {
                    Text("\(formattedDuration) hours")
                    
                    Slider(value: $duration, in: 1...10, step: 0.5) {
                        Text("Duration")
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("🌝 Sleep")
    }
}

struct AddSleepEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddSleepEventView()
    }
}
