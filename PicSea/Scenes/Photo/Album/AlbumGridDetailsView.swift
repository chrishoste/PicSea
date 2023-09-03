import SwiftUI

/// A view displaying details of a photo album.
struct AlbumGridDetailsView: View {
    private let album: Album
    
    /// Initializes an `AlbumGridDetailsView` with the given album.
    ///
    /// - Parameter album: The `Album` object to display details for.
    init(album: Album) {
        self.album = album
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Album \(album.id)")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text("\(album.photos.count)")
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

// MARK: - AlbumGridDetailsView Preview
struct AlbumGridDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumGridDetailsView(album: PreviewMockData.albumSingle)
    }
}
