import Factory
import MabyKit
import SwiftUI

struct AddDiaperEventView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Injected(Container.eventService) private var eventService
    
    @State private var date = Date.now
    @State private var diaperType = DiaperEvent.DiaperType.wet
    
    private func onAdd() {
        let result = eventService.addDiaperChange(date: date, type: diaperType)
        
        switch(result) {
        case .success(_):
            dismiss()
            return
        case .failure(_):
            return
        }
    }
    
    var body: some View {
        AddEventView("🧷 Diaper change", onAdd: onAdd) {
            Section() {
                DatePicker("Date", selection: $date)
                
                Picker("Diaper type", selection: $diaperType) {
                    Text("Wet").tag(DiaperEvent.DiaperType.wet)
                    Text("Dirty").tag(DiaperEvent.DiaperType.dirty)
                    Text("Mixed").tag(DiaperEvent.DiaperType.mixed)
                    Text("Clean").tag(DiaperEvent.DiaperType.clean)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

struct AddDiaperEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaperEventView()
    }
}
