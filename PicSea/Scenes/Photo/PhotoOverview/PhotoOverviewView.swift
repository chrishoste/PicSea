import SwiftUI

/// A view displaying a collection of photos with different layout options.
struct PhotoOverviewView: View {
    
    private let photos: [Photo]
    
    /// The current layout mode for displaying photos.
    @AppStorage(PhotoConstants.overviewLayoutKey) private var currentLayout = PhotoLayout.list
    
    /// Initializes a `PhotoOverviewView` with the given array of photos.
    ///
    /// - Parameter photos: An array of `Photo` objects to display.
    init(photos: [Photo]) {
        self.photos = photos
    }
    
    var body: some View {
        content()
            .padding(.horizontal)
            .navigationTitle("Photos")
            .navigationDestination(for: Photo.self) { photo in
                PhotoDetailView(imageURL: photo.url)
            }
            .toolbar {
                layoutFilterButtons()
            }
    }
}

private extension PhotoOverviewView {
    /// The main content view of the photo overview, determined by the current layout mode.
    @ViewBuilder
    func content() -> some View {
        Group {
            switch currentLayout {
            case .list:
                PhotoListView(photos: photos)
            case .grid:
                PhotoGridView(photos: photos)
            }
        }
    }
    
    /// Creates layout filter buttons in the toolbar.
    @ViewBuilder
    func layoutFilterButtons() -> some View {
        ForEach(PhotoLayout.allCases, id: \.self) { layout in
            Button {
                currentLayout = layout
            } label: {
                Image(systemName: currentLayout == layout ? layout.selectedImageSystemName : layout.imageSystemName)
            }
        }
    }
}

// MARK: - PhotoOverviewView Preview
struct PhotoOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        UIModule.sharedImageService = PreviewMockData.mockImageFetcher
        return NavigationStack {
            PhotoOverviewView(photos: PreviewMockData.photoArray)
        }
    }
}

