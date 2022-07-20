import CoreData
import Factory
import MabyKit
import SwiftUI

struct JournalView: View {
    @Injected(Container.eventService) private var eventService
    
    @SectionedFetchRequest<Date, Event>(
        sectionIdentifier: \.groupStart,
        sortDescriptors: [
            SortDescriptor(\.start, order: .reverse)
        ]
    ) private var events: SectionedFetchResults<Date, Event>
    
    var body: some View {
        List {
            BabyCard()
                .clearBackground()
            
            ForEach(events) { section in
                Section(header: JournalSectionHeader(date: section.id)) {
                    ForEach(section) { event in
                        EventView(event: event)
                    }
                    .onDelete { indexSet in
                        eventService.delete(events: indexSet.map { section[$0] })
                    }
                }
            }
        }
    }
}

private struct JournalSectionHeader: View {
    let date: Date
    
    var body: some View {
        Text(date, format: .dateTime.day().month().year())
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
            .mockedDependencies()
    }
}
