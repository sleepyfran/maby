import CoreData
import MabyKit
import SwiftUI

struct ContentView: View {
    @FetchRequest(fetchRequest: allBabies)
    private var babies: FetchedResults<Baby>
    
    var body: some View {
        NavigationView {
            // In the emulator, CoreData will NEVER sync with CloudKit and therefore
            // we'd never have any data to show even if there's indeed a baby already
            // added in the main app. So only have the check for production. Yeah,
            // I know, I know...
            #if DEBUG
            AddEventListView()
            #else
            if babies.isEmpty {
                VStack(alignment: .leading) {
                    Text("No data")
                        .font(.title)
                    
                    Text("Add a baby in the iOS app first")
                }
            } else {
                AddEventListView()
            }
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
