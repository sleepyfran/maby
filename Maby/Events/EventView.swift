import Factory
import MabyKit
import SwiftUI

// MARK: - Event view
struct EventView: View {
    let event: Event
    
    @ViewBuilder
    private var icon: some View {
        if let _ = event as? DiaperEvent {
            EventIcon(
                icon: "🧷",
                startColor: .orange,
                endColor: .orange.opacity(0.5)
            )
        } else if let _ = event as? NursingEvent {
            EventIcon(
                icon: "🍼",
                startColor: .blue,
                endColor: .blue.opacity(0.5)
            )
        } else if let _ = event as? SleepEvent {
            EventIcon(
                icon: "🌝",
                startColor: .black.opacity(0.8),
                endColor: .black.opacity(0.6)
            )
        } else {
            Text("❓")
        }
    }
    
    @ViewBuilder
    private var details: some View {
        if let diaperEvent = event as? DiaperEvent {
            DiaperEventDetails(event: diaperEvent)
        } else if let nursingEvent = event as? NursingEvent {
            NursingEventDetails(event: nursingEvent)
        } else if let sleepEvent = event as? SleepEvent {
            SleepEventDetails(event: sleepEvent)
        } else {
            Text("❓")
        }
    }
    
    var body: some View {
        HStack {
            icon
                .font(.largeTitle)
            
            details
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Event icon
private struct EventIcon: View {
    let icon: LocalizedStringKey
    let startColor: Color
    let endColor: Color
    
    var body: some View {
        Text(icon)
            .padding(5)
            .background(
                LinearGradient(
                    colors: [startColor, endColor],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(5)
    }
}

// MARK: - Detail specific views
private struct DiaperEventDetails: View {
    let event: DiaperEvent
    
    private var formattedDate: String {
        event.start.formatted(.dateTime.hour().minute())
    }
    
    var diaperTypeText: String {
        switch event.type {
        case .mixed:
            return "Mixed diaper"
        case .wet:
            return "Wet diaper"
        case .clean:
            return "Clean diaper"
        case .dirty:
            return "Dirty diaper"
        }
    }
    
    var body: some View {
        Text("**\(diaperTypeText)** at \(formattedDate)")
    }
}

private struct NursingEventDetails: View {
    let event: NursingEvent
    
    private var breastText: String {
        switch event.breast {
        case .left:
            return "left breast"
        case .right:
            return "right breast"
        case .both:
            return "both breasts"
        }
    }
    
    private var formattedDate: String {
        event.start.formatted(.dateTime.hour().minute())
    }
    
    private var duration: String {
        (event.start..<event.end).formatted(
            .components(
                style: .narrow,
                fields: [.hour, .minute]
            )
        )
    }
    
    var body: some View {
        Text("Nursed from \(breastText) at \(formattedDate) for **\(duration)**")
    }
}

private struct SleepEventDetails: View {
    let event: SleepEvent
    
    private var formattedDate: String {
        event.start.formatted(.dateTime.hour().minute())
    }
    
    private var duration: String {
        (event.start..<event.end).formatted(
            .components(
                style: .narrow,
                fields: [.hour, .minute]
            )
        )
    }
    
    var body: some View {
        Text("Slept for **\(duration)** at \(formattedDate)")
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: DiaperEvent(
            context: Container.previewContainer().viewContext,
            date: Date.now,
            type: DiaperEvent.DiaperType.mixed
        ))
        .previewDisplayName("Diaper event")
        
        EventView(event: NursingEvent(
            context: Container.previewContainer().viewContext,
            start: Date.now,
            end: Date.now.addingTimeInterval(1000),
            breast: .left
        ))
        .previewDisplayName("Nursing event")
        
        EventView(event: SleepEvent(
            context: Container.previewContainer().viewContext,
            start: Date.now,
            end: Date.now.addingTimeInterval(10000)
        ))
        .previewDisplayName("Sleep event")
    }
}
