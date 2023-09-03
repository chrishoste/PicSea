import Foundation

/// A struct representing a photo, conforming to the `Decodable` and `Hashable` protocols.
struct Photo: Decodable, Hashable {
    /// The unique identifier of the photo.
    let id: Int
    /// The identifier of the album that the photo belongs to.
    let albumId: Int
    /// The title or description of the photo.
    let title: String
    /// The URL of the full-sized photo.
    let url: URL
    /// The URL of a thumbnail version of the photo.
    let thumbnailUrl: URL
}
