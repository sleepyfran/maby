import Combine
import MabyKit
import SwiftUI

struct AddEventListView: View {
    var body: some View {
        List {
            BabyCard()
                .clearBackground()
            
            Section("Feeding") {
                AddEventButton<NursingEvent>(
                    "Add nursing",
                    icon: "🤱",
                    type: .nursing
                )
                
                AddEventButton<BottleFeedEvent>(
                    "Add bottle feed",
                    icon: "🍼",
                    type: .bottle
                )
            }
            
            Section("Hygiene") {
                AddEventButton<DiaperEvent>(
                    "Add diaper change",
                    icon: "🧷",
                    type: .diaper
                )
            }
            
            Section("Health") {
                AddEventButton<SleepEvent>(
                    "Add sleep",
                    icon: "🌝",
                    type: .sleep
                )
                
                AddEventButton<VomitEvent>(
                    "Add vomit",
                    icon: "🤢",
                    type: .vomit
                )
            }
        }
    }
}

private struct AddEventButton<E: Event>: View {
    private let text: LocalizedStringKey
    private let icon: LocalizedStringKey
    private let type: EventType
    // TODO: Consider changing timer tick depending on last time (an event that is already more than an hour old doesn't need to be updated every 30 seconds)
    private let updateTimer = Timer.publish(
        every: 30,
        on: .main,
        in: .common
    ).autoconnect()
    
    @State private var selectedType: EventType? = nil
    @State private var lastTime: String? = nil
    
    @FetchRequest(fetchRequest: MabyKit.lastEvent())
    private var lastEvent: FetchedResults<E>
    
    init(
        _ text: LocalizedStringKey,
        icon: LocalizedStringKey,
        type: EventType
    ) {
        self.text = text
        self.icon = icon
        self.type = type
    }
    
    private func updateLastTime() {
        guard let event = lastEvent.first else {
            lastTime = nil
            return
        }
        
        var eventTime: Date
        if let nursingEvent = event as? NursingEvent {
            eventTime = nursingEvent.end
        } else if let sleepEvent = event as? SleepEvent {
            eventTime = sleepEvent.end
        } else {
            eventTime = event.start
        }
        
        lastTime = eventTime.formatted(
            .relative(presentation: .named)
        )
    }
    
    private func onSelect() {
        selectedType = type
    }
    
    var body: some View {
        /// Returns true when `selectedType` contains a value. Whenever set, whether to true or false
        /// it always sets `selectedType` to nil since we are not mutating the value directly, only when
        /// closing SwiftUI will do that for us.
        let showingAddEvent = Binding(
            get: { return selectedType != nil },
            set: { _, _ in selectedType = nil }
        )
        
        return Button(action: onSelect) {
            HStack {
                Text(icon)
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text(text)
                    
                    Text(
                        lastTime == nil
                            ? "No last time"
                            : "Last time \(lastTime!)"
                    )
                    .font(.callout)
                    .foregroundColor(.gray)
                }
            }
        }
        .sheet(isPresented: showingAddEvent) {
            switch selectedType! {
            case .bottle:
                AddBottleFeedEventView()
                    .sheetSize(.medium)
            case .diaper:
                AddDiaperEventView()
                    .sheetSize(.medium)
            case .nursing:
                AddNursingEventView()
                    .sheetSize(.height(450))
            case .sleep:
                AddSleepEventView()
                    .sheetSize(.medium)
            case .vomit:
                AddVomitEventView()
                    .sheetSize(.medium)
            }
        }
        .onAppear {
            updateLastTime()
        }
        .onReceive(lastEvent.publisher) { _ in
            updateLastTime()
        }
        .onReceive(updateTimer) { _ in
            updateLastTime()
        }
    }
}

struct AddEventListView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventListView()
            .mockedDependencies()
    }
}
