import CoreData
import MabyKit
import SwiftUI

struct JournalView: View {
    @FetchRequest(fetchRequest: allBabies)
    private var babies: FetchedResults<Baby>
    
    @SectionedFetchRequest<Date, Event>(
        sectionIdentifier: \.groupStart,
        sortDescriptors: [
            SortDescriptor(\.start, order: .reverse)
        ]
    ) private var events: SectionedFetchResults<Date, Event>
    
    var body: some View {
        List {
            BabyCard(baby: babies.first!)
                .clearBackground()
            
            ForEach(events) { section in
                Section(header: JournalSectionHeader(date: section.id)) {
                    ForEach(section) { event in
                        EventView(event: event)
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
