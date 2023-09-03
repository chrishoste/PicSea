import UIKit

/// Errors that can be thrown by `ImageFetcher`.
enum ImageFetcherError: Error {
    /// An error indicating that the image creation from data failed.
    case failedToCreateImageFromData
}

/// The `ImageFetcher` protocol defines an interface for classes that can fetch images from a remote URL.
protocol ImageFetcher {
    /// Fetches an image from the specified URL asynchronously.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to fetch.
    ///
    /// - Returns: A `UIImage` instance that contains the fetched image.
    ///
    /// - Throws: An `ImageFetcherError` instance if the image fetching fails for any reason.
    func fetchImage(from url: URL) async throws -> UIImage
}

/// The `DefaultImageFetcher` class is an implementation of the `ImageFetcher` protocol that fetches images asynchronously from a remote URL using URLSession.
final actor DefaultImageFetcher: ImageFetcher {
    /// The cache instance that is used to store previously fetched images.
    private var imageCache = NSCache<NSURL, UIImage>()

    /// Fetches an image from the specified URL asynchronously.
    ///
    /// - Parameter url: The URL of the image to fetch.
    ///
    /// - Returns: A `UIImage` instance that contains the fetched image.
    ///
    /// - Throws: An `ImageFetcherError` instance if the image fetching fails for any reason.
    func fetchImage(from url: URL) async throws -> UIImage {
        // Check if the image is already cached
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            return cachedImage
        }

        // Fetch the image data from the URL
        let (data, _) = try await URLSession.shared.data(from: url)

        // Create the UIImage instance from the data
        guard let image = UIImage(data: data) else {
            throw ImageFetcherError.failedToCreateImageFromData
        }

        // Cache the fetched image
        imageCache.setObject(image, forKey: url as NSURL)

        // Return the fetched image
        return image
    }
}
