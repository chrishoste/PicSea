import UIKit
import SwiftUI

/// A protocol defining the photo scene context and its dependencies.
protocol PhotoSceneContext {
    /// Creates and returns the photo list view controller.
    ///
    /// - Returns: A `UIViewController` representing the photo list view.
    func makePhotoListView() -> UIViewController
}

/// The default implementation of the PhotoSceneContext protocol.
class DefaultPhotoSceneContext: PhotoSceneContext {
    
    private let networkClient: NetworkClient
    
    /// Initializes the DefaultPhotoSceneContext with the specified network client.
    ///
    /// - Parameter networkClient: The `NetworkClient` used for making network requests and handling JSON decoding.
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    /// Creates and returns the photo list view controller.
    ///
    /// - Returns: A `UIViewController` representing the photo list view.
    func makePhotoListView() -> UIViewController {
        let viewModel = PhotoSceneViewModel(photoWorker: makePhotoWorker())
        let listView = PhotoScene(viewModel: viewModel)
        
        return UIHostingController(rootView: listView)
    }
    
    /// Creates and returns an instance of `PhotoWorker` using the configured network client.
    ///
    /// - Returns: An instance of `PhotoWorker`.
    private func makePhotoWorker() -> PhotoWorker {
        DefaultPhotoWorker(networkClient: networkClient)
    }
}

/// A struct containing constants related to photos.
enum PhotoConstants {
    /// The URL for fetching photo data from the JSONPlaceholder API.
    static let photoURL = URL(string: "https://jsonplaceholder.typicode.com/photos")
    /// A key for storing and retrieving the current layout state for photo overviews.
    static let overviewLayoutKey = "photo_overview_current_layout"
}
