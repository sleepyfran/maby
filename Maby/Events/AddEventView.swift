import SwiftUI

struct AddEventView<Content: View>: View {
    let title: LocalizedStringKey
    let form: Content
    let onAdd: () -> Void
    
    init(
        _ title: LocalizedStringKey,
        onAdd: @escaping () -> Void,
        @ViewBuilder form: () -> Content
    ) {
        self.title = title
        self.form = form()
        self.onAdd = onAdd
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
                Button(action: onAdd) {
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
        AddEventView("🧷 Diaper change", onAdd: { }) {
            Text("Hello?")
        }
    }
}
