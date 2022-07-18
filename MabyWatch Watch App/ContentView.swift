import CoreData
import MabyKit
import SwiftUI

struct ContentView: View {
    @FetchRequest(fetchRequest: allBabies)
    private var babies: FetchedResults<Baby>
    
    var body: some View {
        NavigationView {
            if babies.isEmpty {
                VStack(alignment: .leading) {
                    Text("No data")
                        .font(.title)
                    
                    Text("Add a baby in the iOS app first")
                }
            } else {
                AddEventListView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
