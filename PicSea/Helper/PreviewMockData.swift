import UIKit

enum PreviewMockData {
    static let photoSingle: Photo = makePhotoObject(1)
    static let photoArray: [Photo] = (1...50).map { index in makePhotoObject(index) }
    
    static let albumSingle: Album = makeAlbumObject()
    static let albumArray: [Album] = (1...50).map { index in makeAlbumObject(index) }
    
    static let mockImageFetcher: ImageFetcher = MockImageFetcher()
}

extension PreviewMockData {
    static func makeAlbumObject(_ id: Int = 1) -> Album {
        .init(id: id, photos: (1...50).map { index in makePhotoObject(index, albumId: id) })
    }
    
    static func makePhotoObject(_ id: Int, albumId: Int = 1) -> Photo {
        .init(id: id,
              albumId: albumId,
              title: "This is the title for mock photo with id \(id)",
              url: .init(string: "https://picsum.photos/id/\(id)/600/600")!,
              thumbnailUrl: .init(string: "https://picsum.photos/id/\(id)/150/150")!)
    }
}

struct MockImageFetcher: ImageFetcher {
    func fetchImage(from url: URL) async throws -> UIImage {
        UIImage(named: "placeholder_600") ?? UIImage()
    }
}
