import SwiftUI

/// A SwiftUI view representing the main scene displaying photo album information.
struct PhotoScene: View {
    /// The view model containing the state and logic for the photo scene.
    @ObservedObject var viewModel: PhotoSceneViewModel
    
    var body: some View {
        content()
            .task {
                await viewModel.fetchAlbums()
            }
    }
}

/// A private extension on PhotoScene providing the main content view of the scene.
private extension PhotoScene {
    /// The main content view of the photo scene, determined by the state of the view model.
    @ViewBuilder
    func content() -> some View {
        VStack(spacing: 0) {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .error:
                ErrorView {
                    Task {
                        await viewModel.fetchAlbums()
                    }
                }
            case .data(let albums):
                NavigationStack {
                    AlbumGridView(albums: albums)
                }
            }
        }
    }
}
