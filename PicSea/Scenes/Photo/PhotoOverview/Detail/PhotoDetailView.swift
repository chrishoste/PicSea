import SwiftUI

/// A view displaying details of a photo.
struct PhotoDetailView: View {
    
    private let imageURL: URL
    
    /// Initializes a `PhotoDetailView` with the given image URL.
    ///
    /// - Parameter imageURL: The URL of the photo to display.
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: imageURL)
                .frame(height: 100)
        }
        .toolbar {
            contextMenu()
        }
    }
}

private extension PhotoDetailView {
    /// Creates a context menu with options for the photo.
    @ViewBuilder
    func contextMenu() -> some View {
        Menu {
            Button("Copy URL") {
                UIPasteboard.general.string = imageURL.absoluteString
            }
        } label: {
            Button {} label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}

// MARK: - PhotoDetailView Preview
struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UIModule.sharedImageService = PreviewMockData.mockImageFetcher
        return NavigationStack {
            PhotoDetailView(imageURL: PreviewMockData.photoSingle.url)
        }
    }
}
