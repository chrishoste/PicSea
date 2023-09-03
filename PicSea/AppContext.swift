import UIKit

// MARK: - UIModule
/// UIModule struct for providing global access to shared `ImageFetcher` instance. This can easily be overridden during testing.
public struct UIModule {
    static var sharedImageService: ImageFetcher?
}

// MARK: - AppContext
/// A protocol defining the application context and its dependencies.
protocol AppContext {
    /// Retrieves the entry view controller for the application.
    ///
    /// - Returns: The entry view controller that should be displayed when the application starts.
    func entryViewController() -> UIViewController
}

/// The default implementation of the AppContext protocol, providing access to dependencies.
final class DefaultAppContext: AppContext {
    
    init() {
        // Set up the default image fetcher for the application.
        UIModule.sharedImageService = DefaultImageFetcher()
    }
    
    /// The network client used for making network requests and handling JSON decoding.
    lazy var networkClient: NetworkClient = {
        DefaultNetworkClient()
    }()
    
    /// The photo scene context, which provides access to photo-related scenes and data.
    lazy var photoSceneContext: PhotoSceneContext = {
        DefaultPhotoSceneContext(networkClient: networkClient)
    }()
    
    /// Retrieves the entry view controller for the application.
    ///
    /// - Returns: The entry view controller for the application.
    func entryViewController() -> UIViewController {
        // Create and return the initial view controller for the application.
        return photoSceneContext.makePhotoListView()
    }
}
