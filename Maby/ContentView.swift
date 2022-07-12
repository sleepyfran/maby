import CoreData
import Factory
import MabyKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AddEventView()
                .tabItem {
                    Label("Add event", systemImage: "plus")
                }
            
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "book")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .mockedDependencies()
    }
}
