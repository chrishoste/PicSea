import Foundation

/// An error type representing potential errors encountered in the PhotoWorker.
enum PhotoWorkerError: Error {
    /// An error case indicating a failure to unwrap the photo URL.
    case failedToUnwrapURL
}

/// A protocol defining the PhotoWorker's responsibilities and its dependencies.
protocol PhotoWorker {
    /// Asynchronously fetches albums and returns an array of Album objects.
    ///
    /// - Returns: An array of Album objects representing photo albums.
    ///
    /// - Throws: An error of type `PhotoWorkerError` if there's a problem with fetching or processing the photo data.
    func fetchAlbums() async throws -> [Album]
}

/// The default implementation of the PhotoWorker protocol.
struct DefaultPhotoWorker: PhotoWorker {
    /// The network client used for making network requests and handling JSON decoding.
    private let networkClient: NetworkClient
    
    /// Initializes the DefaultPhotoWorker with the specified network client.
    ///
    /// - Parameter networkClient: The NetworkClient used for making network requests and handling JSON decoding.
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    /// Asynchronously fetches albums and returns an array of Album objects.
    ///
    /// - Returns: An array of Album objects representing photo albums.
    ///
    /// - Throws: An error of type `PhotoWorkerError` if there's a problem with fetching or processing the photo data.
    func fetchAlbums() async throws -> [Album] {
        let photos = try await fetchPhotos()
        
        return photos.asAlbums
    }
}

private extension DefaultPhotoWorker {
    /// Asynchronously fetches photo data and returns an array of Photo objects.
    ///
    /// - Returns: An array of Photo objects representing photo data.
    ///
    /// - Throws: An error of type `PhotoWorkerError` if there's a problem with fetching or processing the photo data.
    func fetchPhotos() async throws -> [Photo] {
        guard let url = PhotoConstants.photoURL else {
            throw PhotoWorkerError.failedToUnwrapURL
        }
        
        return try await networkClient.fetch(from: url)
    }
}

private extension Array where Element == Photo {
    var asAlbums: [Album] {
        // Create a dictionary to group photos by albumId
        var albumDict: [Int: [Photo]] = [:]

        for photo in self {
            if albumDict[photo.albumId] == nil {
                albumDict[photo.albumId] = [photo]
            } else {
                albumDict[photo.albumId]?.append(photo)
            }
        }

        // Create Album objects from the grouped photos
        var albums: [Album] = []

        for (albumId, albumPhotos) in albumDict {
            let album = Album(id: albumId, photos: albumPhotos)
            albums.append(album)
        }

        return albums.sorted(by: \.id)
    }
}
