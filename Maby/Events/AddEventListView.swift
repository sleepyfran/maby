import MabyKit
import SwiftUI

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
                    Text("🤢 Add vomit")
                }
            }
        }
        .sheet(isPresented: showingAddEvent, onDismiss: onDismiss) {
            switch selectedType! {
            case .diaper:
                AddDiaperEventView()
                    .sheetSize(.medium)
            case .nursing:
                AddNursingEventView()
                    .sheetSize(.height(450))
            case .sleep:
                AddSleepEventView()
                    .sheetSize(.medium)
            case .vomit:
                AddVomitEventView()
                    .sheetSize(.medium)
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
