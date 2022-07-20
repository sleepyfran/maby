import MabyKit
import SwiftUI

struct BabyDetailsFormView<Confirm: View>: View {
    let title: LocalizedStringKey
    let confirmButton: Confirm
    
    @Binding private var name: String
    @Binding private var gender: Baby.Gender
    @Binding private var birthday: Date
    
    init(
        title: LocalizedStringKey,
        name: Binding<String>,
        gender: Binding<Baby.Gender>,
        birthday: Binding<Date>,
        @ViewBuilder _ button: () -> Confirm
    ) {
        self.title = title
        self._name = name
        self._gender = gender
        self._birthday = birthday
        self.confirmButton = button()
    }
    
    private var disableButton: Bool {
        !isValidBaby(name: name, birthday: birthday)
    }
    
    var body: some View {
        Form {
            VStack {
                Text("👶🏻")
                    .font(.system(size: 80))
                    .frame(maxWidth: .infinity)
                
                Text(title)
                    .font(.largeTitle)
            }
            .clearBackground()
            
            Section("Name") {
                TextField("Baby's name", text: $name)
            }
            
            Section("Baby's info") {
                Picker("Gender", selection: $gender) {
                    Text("Boy")
                        .tag(Baby.Gender.boy)
                    Text("Girl")
                        .tag(Baby.Gender.girl)
                    Text("Other")
                        .tag(Baby.Gender.other)
                }
                
                DatePicker(
                    "Birthday",
                    selection: $birthday,
                    in: Date.distantPast...Date.now,
                    displayedComponents: [.date]
                )
            }
            
            confirmButton
                .disabled(disableButton)
                .buttonStyle(.primaryAction)
                .clearBackground()
        }
    }
}

struct BabyDetailsFormView_Previews: PreviewProvider {
    static var previews: some View {
        BabyDetailsFormView(
            title: "Add baby",
            name: Binding.constant("Test"),
            gender: Binding.constant(Baby.Gender.girl),
            birthday: Binding.constant(Date.now)
        ) {
            Button(action: { }) {
                Text("Add baby")
            }
        }
    }
}
