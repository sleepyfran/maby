import MabyKit
import SwiftUI

private enum ButtonState {
    case resting, loading, success, errored
}

struct AddEventView<Content: View, E: Event>: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: LocalizedStringKey
    let form: Content
    let onAdd: () -> Result<E, AddError>
    
    @State private var buttonState: ButtonState = .resting
    
    init(
        _ title: LocalizedStringKey,
        onAdd: @escaping () -> Result<E, AddError>,
        @ViewBuilder form: () -> Content
    ) {
        self.title = title
        self.form = form()
        self.onAdd = onAdd
    }
    
    private var disableAddButton: Bool {
        [
            ButtonState.loading,
            ButtonState.success,
            ButtonState.errored
        ].contains(buttonState)
    }
    
    private var buttonTint: Color {
        switch buttonState {
        case .resting:
            fallthrough
        case .loading:
            return Color.blue
        case .success:
            return Color.green
        case .errored:
            return Color.red
        }
    }
    
    private func addAndDismiss() {
        if disableAddButton {
            return
        }
        
        buttonState = .loading
        
        let result = onAdd()
        
        switch result {
        case .success(_):
            buttonState = .success
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                dismiss()
            }
            
            return
        case .failure(_):
            buttonState = .errored
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                buttonState = .resting
            }
            
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
                    switch buttonState {
                    case .resting:
                        Text("Add")
                    case .loading:
                        Text("Adding...")
                    case .success:
                        Text("Added!")
                    case .errored:
                        Text("Try again...")
                    }
                }
                .tint(buttonTint)
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
