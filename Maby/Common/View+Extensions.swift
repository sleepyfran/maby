import Factory
import SwiftUI

// MARK: - Background extensions
extension View {
    /// Removes the list row background of the view.
    public func clearBackground() -> some View {
        self.listRowBackground(Color.clear)
    }
}

// MARK: - Debug extensions
extension View {
    /// Adds all the mocked dependencies to a view. Use ONLY on previews.
    public func mockedDependencies(empty: Bool = false) -> some View {
        #if DEBUG
        return self
            .environment(
                \.managedObjectContext,
                empty
                 ? Container.emptyPreviewContainer().viewContext
                 : Container.previewContainer().viewContext
            )
        #else
        return self
        #endif
    }
}
