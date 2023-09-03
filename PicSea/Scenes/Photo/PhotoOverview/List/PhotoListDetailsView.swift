import SwiftUI

/// A view displaying details of a photo in a list view.
struct PhotoListDetailsView: View {
    private let photo: Photo
    
    /// Initializes a `PhotoListDetailsView` with the given photo.
    ///
    /// - Parameter photo: The `Photo` object to display details for.
    init(photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("# \(photo.id) in Album \(photo.albumId)")
                .font(.caption)
                .fontWeight(.heavy)
                .foregroundColor(.secondary)
            Text(photo.title)
        }
    }
}

// MARK: - PhotoListDetailsView Preview
struct PhotoListDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationStack {
            PhotoListDetailsView(photo: PreviewMockData.photoSingle)
        }
    }
}
