import SwiftUI

struct ContentView: View {
    @StateObject var rootViewModel: RootViewModel = RootViewModel()
    var body: some View {
        RootView(viewModel: rootViewModel)
    }
}

