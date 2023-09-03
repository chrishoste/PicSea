import SwiftUI

/// A view displaying a grid of photos.
struct PhotoGridView: View {
    
    private let photos: [Photo]
    private let columns: [GridItem] = (0...2).map { _ in GridItem(.flexible()) }
    
    /// Initializes a `PhotoGridView` with the given array of photos.
    ///
    /// - Parameter photos: An array of `Photo` objects to display.
    init(photos: [Photo]) {
        self.photos = photos
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(photos, id: \.id) { photo in
                    NavigationLink(destination: PhotoDetailView(imageURL: photo.url)) {
                        CachedAsyncImage(url: photo.thumbnailUrl)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

// MARK: - PhotoGridView Preview
struct PhotoGridView_Previews: PreviewProvider {
    static var previews: some View {
        UIModule.sharedImageService = PreviewMockData.mockImageFetcher
        return NavigationStack {
            PhotoGridView(photos: PreviewMockData.photoArray)
        }
    }
}
