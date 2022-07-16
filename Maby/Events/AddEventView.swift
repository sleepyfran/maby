import MabyKit
import SwiftUI

struct AddEventView<Content: View, E: Event>: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: LocalizedStringKey
    let form: Content
    let onAdd: () -> Result<E, AddError>
    
    init(
        _ title: LocalizedStringKey,
        onAdd: @escaping () -> Result<E, AddError>,
        @ViewBuilder form: () -> Content
    ) {
        self.title = title
        self.form = form()
        self.onAdd = onAdd
    }
    
    private func addAndDismiss() {
        let result = onAdd()
        
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
            Section {
                Text(title)
                    .font(.largeTitle)
            }
            .clearBackground()
            
            form
            
            Section {
                Button(action: addAndDismiss) {
                    Text("Add")
                }
                .buttonStyle(.primaryAction)
            }
            .clearBackground()
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(
            "🧷 Diaper change",
            onAdd: { .failure(.databaseError) }
        ) {
            Text("Hello?")
        }
    }
}
