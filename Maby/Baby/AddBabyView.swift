import Factory
import MabyKit
import SwiftUI

struct AddBabyView: View {
    @Injected(Container.babyService) private var babyService
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var gender = Baby.Gender.boy
    @State private var birthday = Date.now
    
    private var birthdayRange: ClosedRange<Date> {
        let now = Date.now
        let fiveYearsAgo = Calendar.current.date(
            byAdding: .year,
            value: -5,
            to: Date.now
        )!
        
        return fiveYearsAgo...now
    }
    
    private var disableAddButton: Bool {
        !isValidBaby(name: name, birthday: birthday)
    }
    
    private func onAdd() {
        let result = babyService.add(
            name: name,
            birthday: birthday,
            gender: gender
        )
        
        switch result {
        case .success(_):
            dismiss()
            return
        case .failure(_):
            return
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("👶🏻")
                        .font(.system(size: 80))
                        .frame(maxWidth: .infinity)
                    
                    Text("Add a baby")
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
                        in: birthdayRange,
                        displayedComponents: [.date]
                    )
                }
                
                Button(action: onAdd) {
                    Text("Add baby")
                }
                .clearBackground()
                .disabled(disableAddButton)
                .buttonStyle(.primaryAction)
            }
        }
        .navigationTitle("Add a baby")
    }
}

struct AddBabyView_Previews: PreviewProvider {
    static var previews: some View {
        AddBabyView()
            .sheet(isPresented: Binding.constant(true)) {
                AddBabyView()
            }
    }
}
