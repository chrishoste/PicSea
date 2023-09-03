import SwiftUI

/// A SwiftUI view representing a loading indicator with a text.
struct LoadingView: View {
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text("Loading ...")
        }
    }
}

// MARK: - LoadingView Preview
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
