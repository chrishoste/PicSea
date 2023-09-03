import Foundation

/// The view model for the Photo Scene, responsible for managing the state and data related to photo albums.
class PhotoSceneViewModel: ObservableObject {
    /// The current state of the Photo Scene, represented as a published property.
    @Published var state: State = .loading

    /// The photo worker responsible for fetching photo album data.
    private let photoWorker: PhotoWorker
    
    /// Initializes the PhotoSceneViewModel with the specified photo worker.
    ///
    /// - Parameter photoWorker: The `PhotoWorker` used for fetching photo album data.
    init(photoWorker: PhotoWorker) {
        self.photoWorker = photoWorker
    }
    
    /// Asynchronously fetches photo album data and updates the state accordingly.
    @MainActor
    func fetchAlbums() async {
        state = .loading
        do {
            state = .data(try await photoWorker.fetchAlbums())
        } catch {
            state = .error
        }
    }
}

/// An extension of PhotoSceneViewModel defining its possible states.
extension PhotoSceneViewModel {
    /// Represents the different states of the Photo Scene view model.
    enum State {
        /// The loading state, indicating that photo album data is being fetched.
        case loading
        /// The error state, indicating that an error occurred while fetching photo album data.
        case error
        /// The data state, containing an array of `Album` objects fetched successfully.
        case data([Album])
    }
}
