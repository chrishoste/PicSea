import SwiftUI

/// A SwiftUI view that displays an asynchronously loaded image and handles error states.
struct CachedAsyncImage: View {
    
    @StateObject private var imageLoader: ImageLoader
    
    private let url: URL
    private let imageFetcher: ImageFetcher?
    
    /// Initializes a `CachedAsyncImage` with the specified URL and optional `ImageFetcher`.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to load.
    ///   - imageFetcher: An optional `ImageFetcher` to use for loading the image.
    init(url: URL, imageFetcher: ImageFetcher? = UIModule.sharedImageService) {
        self.url = url
        self.imageFetcher = imageFetcher
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url, imageFetcher: imageFetcher))
    }
    
    var body: some View {
        Group {
            if let state = imageLoader.state {
                switch state {
                case .image(let image):
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fill)
                case .error:
                    Rectangle()
                        .fill(Color.secondary)
                        .aspectRatio(1.0, contentMode: .fill)
                        .overlay {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(Color.primary)
                        }
                }
            } else {
                Rectangle()
                    .fill(Color.secondary)
                    .aspectRatio(1.0, contentMode: .fill)
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .onAppear {
            imageLoader.loadImage()
        }
    }
}

private extension ImageLoader {
    /// Represents the state of image loading.
    enum State {
        case error(Error)
        case image(UIImage)
    }
}

private class ImageLoader: ObservableObject {
    @Published var state: State?
    
    private let url: URL
    private let imageFetcher: ImageFetcher?
    
    /// Initializes an `ImageLoader` with the specified URL and optional `ImageFetcher`.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to load.
    ///   - imageFetcher: An optional `ImageFetcher` to use for loading the image.
    init(url: URL, imageFetcher: ImageFetcher?) {
        self.url = url
        self.imageFetcher = imageFetcher
    }
    
    /// Asynchronously loads the image from the specified URL and updates the state accordingly.
    func loadImage() {
        Task {
            do {
                guard let fetchedImage = try await imageFetcher?.fetchImage(from: url) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.state = .image(fetchedImage)
                }
            } catch {
                self.state = .error(error)
            }
        }
    }
}
