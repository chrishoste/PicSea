import SwiftUI

/// A view displaying a grid of photo albums.
struct AlbumGridView: View {
    
    private let albums: [Album]
    private let columns: [GridItem] = (0...1).map { _ in GridItem(.flexible()) }
    
    /// Initializes an `AlbumGridView` with the given array of albums.
    ///
    /// - Parameter albums: An array of `Album` objects to display.
    init(albums: [Album]) {
        self.albums = albums
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(albums, id: \.id) { album in
                    NavigationLink(destination: PhotoOverviewView(photos: album.photos)) {
                        VStack {
                            CachedAsyncImage(url: album.photos.first!.thumbnailUrl)
                            AlbumGridDetailsView(album: album)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationTitle("Albums")
    }
}

// MARK: - AlbumGridView Preview
struct AlbumGridView_Previews: PreviewProvider {
    static var previews: some View {
        UIModule.sharedImageService = PreviewMockData.mockImageFetcher
        return AlbumGridView(albums: PreviewMockData.albumArray)
    }
}

