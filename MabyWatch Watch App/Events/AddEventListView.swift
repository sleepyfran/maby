import MabyKit
import SwiftUI

struct AddEventListView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Feeding") {
                    NavigationLink(destination: AddNursingEventView()) {
                        Text("🤱 Nursing")
                    }
                    
                    NavigationLink(destination: AddBottleFeedEventView()) {
                        Text("🍼 Bottle")
                    }
                }
                
                Section("Hygiene") {
                    NavigationLink(destination: AddDiaperEventView()) {
                        Text("🧷 Diaper change")
                    }
                }
                
                Section("Health") {
                    NavigationLink(destination: AddSleepEventView()) {
                        Text("🌝 Sleep")
                    }
                    
                    NavigationLink(destination: AddVomitEventView()) {
                        Text("🤢 Vomit")
                    }
                }
            }
        }
        .navigationTitle("Add event")
    }
}

struct AddEventListView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventListView()
    }
}
