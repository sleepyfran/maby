import MabyKit
import SwiftUI

struct AddEventView<Content: View, E: Event>: View {
    @Environment(\.dismiss) private var dismiss
    
    let content: Content
    let onAdd: () -> Result<E, AddError>
    
    @State private var loading = false
    
    init(
        action: @escaping () -> Result<E, AddError>,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.onAdd = action
    }
    
    private func addAndDismiss() {
        loading = true
        
        let result = onAdd()
        
        loading = false
        
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
            content
            
            Button(action: addAndDismiss) {
                if loading {
                    Text("Adding...")
                } else {
                    Text("Add")
                }
            }
            .disabled(loading)
            .buttonStyle(.borderedProminent)
            .listRowBackground(Color.clear)
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(action: { .failure(.databaseError) }) {
            Text("Hello!")
        }
    }
}
