import Foundation

/// A struct representing an album, conforming to the `Decodable` and `Hashable` protocols.
struct Album: Decodable, Hashable {
    /// The unique identifier of the album.
    let id: Int
    /// An array of `Photo` objects representing the photos in the album.
    let photos: [Photo]
}
