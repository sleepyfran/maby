import Factory
import SwiftUI

extension View {
    public func mockedDependencies() -> some View {
        #if DEBUG
        return self
            .environment(\.managedObjectContext, Container.previewContainer().viewContext)
        #else
        return self
        #endif
    }
}
