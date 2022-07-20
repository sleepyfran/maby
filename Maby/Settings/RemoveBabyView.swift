import Factory
import MabyKit
import SwiftUI

struct RemoveBabyView: View {
    @Injected(Container.babyService) private var babyService
    
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest private var babies: FetchedResults<Baby>
    
    init() {
        self._babies = FetchRequest(fetchRequest: allBabies)
    }
    
    private var baby: Baby? {
        babies.first
    }
    
    private func onRemove() {
        if baby == nil {
            return
        }
        
        babyService.remove(baby: baby!)
        dismiss()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Remove \(baby?.name ?? "")")
                .font(.title)
                .bold()
            
            Text("This will remove all data related to the baby and **cannot** be undone. Are you sure?")
            
            Button(action: onRemove) {
                Text("Yes, delete it")
            }
            .buttonStyle(.primaryAction)
            .tint(.red)
            
            Button(action: { dismiss() }) {
                Text("No! Cancel")
            }
            .buttonStyle(.secondaryAction)
        }
        .padding()
    }
}

struct RemoveBabyView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
            .sheet(isPresented: Binding.constant(true)) {
                RemoveBabyView()
                    .sheetSize(.medium)
                    .mockedDependencies()
            }
    }
}
