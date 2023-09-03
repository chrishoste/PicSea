import SwiftUI

/// A view displaying a list of photos.
struct PhotoListView: View {
    
    private let photos: [Photo]
    private let columns: [GridItem] = [GridItem(.flexible())]
    
    /// Initializes a `PhotoListView` with the given array of photos.
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
                        HStack(alignment: .top) {
                            CachedAsyncImage(url: photo.thumbnailUrl)
                                .frame(width: 100)
                            
                            PhotoListDetailsView(photo: photo)
                            
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

// MARK: - PhotoListView Preview
struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        UIModule.sharedImageService = PreviewMockData.mockImageFetcher
        return NavigationStack {
            PhotoListView(photos: PreviewMockData.photoArray)
        }
    }
}
