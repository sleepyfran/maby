import Factory
import MabyKit
import SwiftUI

struct AddNursingEventView: View {
    @Injected(Container.eventService) private var eventService
    @Environment(\.dismiss) private var dismiss
    
    @State private var duration = 15.0
    @State private var breast = NursingEvent.Breast.left
    
    private var formattedDuration: String {
        duration.formatted(.number.rounded(rule: .up))
    }
    
    private var breastText: String {
        switch breast {
        case .left:
            return "Left"
        case .right:
            return "Right"
        case .both:
            return "Both"
        }
    }
    
    private func onAdd() {
        let result = eventService.addNursing(duration: duration, breast: breast)
        switch result {
        case .success(_):
            dismiss()
            return
        case .failure(_):
            return
        }
    }
    
    var body: some View {
        Form {
            Section("Duration") {
                VStack(alignment: .leading) {
                    Text("\(formattedDuration) minutes")
                    
                    Slider(value: $duration, in: 1...60, step: 1) {
                        Text("Duration")
                    }
                }
                .padding(.vertical)
            }
            
            Picker("Breast", selection: $breast) {
                Text("Left").tag(NursingEvent.Breast.left)
                Text("Right").tag(NursingEvent.Breast.right)
                Text("Both").tag(NursingEvent.Breast.both)
            }
            .pickerStyle(.inline)
            
            Button(action: onAdd) {
                Text("Add")
            }
            .buttonStyle(.borderedProminent)
            .listRowBackground(Color.clear)
        }
        .navigationTitle("🍼 Nursing")
    }
}

struct AddNursingEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNursingEventView()
        }
    }
}