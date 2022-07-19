import Factory
import MabyKit
import SwiftUI

@main
struct MabyWatch_Watch_AppApp: App {
    @Injected(Container.container) private var persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
