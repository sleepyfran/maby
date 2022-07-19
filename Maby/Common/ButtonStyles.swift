import SwiftUI

private struct FormActionButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.trigger() }) {
            configuration.label
                .frame(maxWidth: .infinity)
        }
        .controlSize(.large)
    }
}

/// Button style for primary action buttons inside a form.
struct FormPrimaryActionButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.trigger() }) {
            configuration.label
        }
        .buttonStyle(FormActionButtonStyle())
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

/// Button style for secondary action buttons inside a form.
struct FormSecondaryActionButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.trigger() }) {
            configuration.label
        }
        .buttonStyle(FormActionButtonStyle())
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

extension PrimitiveButtonStyle where Self == FormPrimaryActionButtonStyle {
    static var primaryAction: FormPrimaryActionButtonStyle {
        FormPrimaryActionButtonStyle()
    }
    
    static var secondaryAction: FormSecondaryActionButtonStyle {
        FormSecondaryActionButtonStyle()
    }
}

struct FormButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: { }) {
                Text("Do the thing")
            }
            .buttonStyle(FormPrimaryActionButtonStyle())
            
            Button(action: { }) {
                Text("Do not do the thing")
            }
            .buttonStyle(FormSecondaryActionButtonStyle())
        }
    }
}
