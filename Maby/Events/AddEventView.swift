import MabyKit
import SwiftUI

struct AddEventView: View {
    @FetchRequest(fetchRequest: allBabies())
    private var babies: FetchedResults<Baby>
    
    var body: some View {
        VStack {
            BabyCard(baby: babies.first!)
            
            Spacer()
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
            .mockedDependencies()
    }
}
