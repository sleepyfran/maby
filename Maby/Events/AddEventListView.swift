import MabyKit
import SwiftUI

private enum EventType {
    case nursing, diaper, sleep, vomit
}

struct AddEventListView: View {
    @FetchRequest(fetchRequest: allBabies)
    private var babies: FetchedResults<Baby>
    
    @State private var selectedType: EventType? = nil
    
    private func onSelect(type: EventType) {
        selectedType = type
    }
    
    private func onDismiss() {
        selectedType = nil
    }
    
    var body: some View {
        /// Returns true when `selectedType` contains a value. Whenever set, whether to true or false
        /// it always sets `selectedType` to nil since we are not mutating the value directly, only when
        /// closing SwiftUI will do that for us.
        let showingAddEvent = Binding(
            get: { return selectedType != nil },
            set: { _, _ in selectedType = nil }
        )
        
        return List {
            BabyCard(baby: babies.first!)
                .clearBackground()
            
            Section("Feeding") {
                Button(action: { onSelect(type: .nursing) }) {
                    Text("🍼 Add nursing")
                }
            }
            
            Section("Hygiene") {
                Button(action: { onSelect(type: .diaper) }) {
                    Text("🧷 Add diaper change")
                }
            }
            
            Section("Health") {
                Button(action: { onSelect(type: .sleep) }) {
                    Text("🌝 Add sleep")
                }
                
                Button(action: { onSelect(type: .vomit) }) {
                    Text("🤢 Vomit")
                }
            }
        }
        .sheet(isPresented: showingAddEvent, onDismiss: onDismiss) {
            switch selectedType! {
            case .diaper:
                AddDiaperEventView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            case .nursing:
                AddNursingEventView()
                    .presentationDetents([.height(450)])
                    .presentationDragIndicator(.visible)
            case .sleep:
                AddSleepEventView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            case .vomit:
                AddVomitEventView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct AddEventListView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventListView()
            .mockedDependencies()
    }
}
