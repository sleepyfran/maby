import Factory
import MabyKit
import SwiftUI

struct EditBabyDetailsView: View {
    @Injected(Container.babyService) private var babyService
    
    @FetchRequest(fetchRequest: allBabies)
    private var babies: FetchedResults<Baby>
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var gender = Baby.Gender.boy
    @State private var birthday = Date.now
    
    private func onEdit() {
        let result = babyService.edit(
            baby: babies.first!,
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
        BabyDetailsFormView(
            title: "Edit baby",
            name: $name,
            gender: $gender,
            birthday: $birthday
        ) {
            Button(action: onEdit) {
                Text("Edit baby")
            }
        }
        .onAppear {
            if babies.isEmpty {
                return
            }
            
            let baby = babies.first!
            
            self.name = baby.name
            self.gender = baby.gender
            self.birthday = baby.birthday
        }
    }
}

struct EditBabyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EditBabyDetailsView()
            .mockedDependencies()
    }
}
