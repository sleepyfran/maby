import CoreData
import MabyKit
import SwiftUI

struct JournalView: View {
    @FetchRequest(fetchRequest: allBabies())
    private var babies: FetchedResults<Baby>
    
    var body: some View {
        VStack {
            BabyCard(baby: babies.first!)
            
            Spacer()
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
            .mockedDependencies()
    }
}
