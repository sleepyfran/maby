import MabyKit
import SwiftUI

private enum ButtonState {
    case resting, loading, success, errored
}

struct AddEventView<Content: View, E: Event>: View {
    @Environment(\.dismiss) private var dismiss
    
    let content: Content
    let onAdd: () -> Result<E, AddError>
    
    @State private var buttonState: ButtonState = .resting
    
    init(
        action: @escaping () -> Result<E, AddError>,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.onAdd = action
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
        buttonState = .loading
        
        let result = onAdd()
        
        switch result {
        case .success(_):
            buttonState = .success
            
            WKInterfaceDevice.current().play(.success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
            content
            
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
            .disabled(disableAddButton)
            .buttonStyle(.borderedProminent)
            .tint(buttonTint)
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
