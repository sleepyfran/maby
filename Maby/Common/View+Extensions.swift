import Factory
import SwiftUI

// MARK: - Background extensions
extension View {
    /// Removes the list row background of the view.
    public func clearBackground() -> some View {
        self.listRowBackground(Color.clear)
    }
}

// MARK: - Sheet extensions
public enum DetentsSize {
    case medium, height(CGFloat)
}

extension View {
    /// Calls the `presentationsDetents` and `presentationDragIndicator` functions on the
    /// current view if available with the given size.
    @ViewBuilder
    public func sheetSize(_ size: DetentsSize) -> some View {
        if #available(iOS 16, *) {
            switch size {
            case .medium:
                self.presentationDetents([.medium])
                           .presentationDragIndicator(.visible)
            case .height(let height):
                self.presentationDetents([.height(height)])
                           .presentationDragIndicator(.visible)
            }
        } else {
            self
        }
    }
}

// MARK: - Debug extensions
extension View {
    /// Adds all the mocked dependencies to a view. Use ONLY on previews.
    @ViewBuilder
    public func mockedDependencies(empty: Bool = false) -> some View {
        #if DEBUG
        let viewContext =
            empty
             ? Container.emptyPreviewContainer().viewContext
             : Container.previewContainer().viewContext
        
        self
            .environment(\.managedObjectContext, viewContext)
        #else
        self
        #endif
    }
}
