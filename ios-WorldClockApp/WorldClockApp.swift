import SwiftUI

@main
struct WorldClockApp: App {
    var body: some Scene {
        WindowGroup {
            WorldClockAppView(viewModel: WorldClockAppViewModel())
        }
    }
}
