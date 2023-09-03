import Foundation

/// An enumeration representing different layout options for displaying photos.
enum PhotoLayout: String, CaseIterable {
    /// The list layout option.
    case list
    /// The grid layout option.
    case grid
    
    /// A system name for displaying the layout option as an image.
    var imageSystemName: String {
        switch self {
        case .list: return "list.bullet"
        case .grid: return "square.grid.2x2"
        }
    }
    
    /// A selected system name for displaying the layout option as a selected image.
    var selectedImageSystemName: String {
        switch self {
        case .list: return imageSystemName
        case .grid: return "square.grid.2x2.fill"
        }
    }
}
