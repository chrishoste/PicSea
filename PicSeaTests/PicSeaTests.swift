import XCTest
@testable import PicSea

final class PicSeaTests: XCTestCase {

    /// Test that the correct number of albums are fetched.
    /// - Throws: An error if the albums count doesn't match the expected value.
    func testFetchingAlbumsCount() async throws {
        let photoWorker = DefaultPhotoWorker(networkClient: MockPhotoNetworkClient())
        let albums = try await photoWorker.fetchAlbums()
        
        XCTAssertEqual(albums.count, 7, "The number of fetched albums does not match the expected count.")
    }
    
    /// Test that album IDs are within the expected range.
    /// - Throws: An error if any album ID is outside the expected range.
    func testAlbumIdsInRange() async throws {
        let photoWorker = DefaultPhotoWorker(networkClient: MockPhotoNetworkClient())
        let albums = try await photoWorker.fetchAlbums()
        
        for index in (1...7) {
            XCTAssertNotNil(albums.first { $0.id == index }, "Album with ID \(index) not found.")
        }
    }
    
    /// Test that invalid album IDs are not present.
    /// - Throws: An error if any album with invalid ID is found.
    func testInvalidAlbumIds() async throws {
        let photoWorker = DefaultPhotoWorker(networkClient: MockPhotoNetworkClient())
        let albums = try await photoWorker.fetchAlbums()
        
        XCTAssertNil(albums.first { $0.id == 0 }, "Album with ID 0 found.")
        
        for index in (8...100) {
            XCTAssertNil(albums.first { $0.id == index }, "Album with ID \(index) found.")
        }
    }
    
    /// Test that the number of photos in each album matches the expectations.
    /// - Throws: An error if any album's photo count does not match the expected count.
    func testPhotosCountInAlbums() async throws {
        let photoWorker = DefaultPhotoWorker(networkClient: MockPhotoNetworkClient())
        let albums = try await photoWorker.fetchAlbums()
        
        let expectations = [(1, 50), (2, 40), (3, 30), (4, 20), (5, 10), (6, 5), (7, 50)]
        
        for expectation in expectations {
            XCTAssertEqual(
                albums.first { $0.id == expectation.0 }?.photos.count,
                expectation.1,
                "Album with ID \(expectation.0) does not have the expected photo count."
            )
        }
    }
}

// MARK: Mocks and Data
private struct MockPhotoNetworkClient: NetworkClient {
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        guard let photoArray =  PicSeaTestsMockData.allPhotos as? T else {
            fatalError("Unexpected data type received during testing.")
        }
        
        return photoArray
    }
}

private enum PicSeaTestsMockData {
    static let photoArray1: [Photo] = (1...50).map { index in PreviewMockData.makePhotoObject(index, albumId: 1) }
    static let photoArray2: [Photo] = (1...40).map { index in PreviewMockData.makePhotoObject(index, albumId: 2) }
    static let photoArray3: [Photo] = (1...30).map { index in PreviewMockData.makePhotoObject(index, albumId: 3) }
    static let photoArray4: [Photo] = (1...20).map { index in PreviewMockData.makePhotoObject(index, albumId: 4) }
    static let photoArray5: [Photo] = (1...10).map { index in PreviewMockData.makePhotoObject(index, albumId: 5) }
    static let photoArray6: [Photo] = (1...5).map { index in PreviewMockData.makePhotoObject(index, albumId: 6) }
    static let photoArray7: [Photo] = (1...50).map { index in PreviewMockData.makePhotoObject(index, albumId: 7) }
    
    static let allPhotos = photoArray1 + photoArray2 + photoArray3 + photoArray4 + photoArray5 + photoArray6 + photoArray7
}
