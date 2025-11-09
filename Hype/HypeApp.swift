import SwiftUI

@main
struct HypeApp: App {
    @State private var showLaunchScreen = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()

                LaunchScreenView()
                    .opacity(showLaunchScreen ? 1.0 : 0.0)
                    .allowsHitTesting(showLaunchScreen)
                    .zIndex(showLaunchScreen ? 1 : 0)
            }
            .animation(.easeOut(duration: 0.5), value: showLaunchScreen)
            .onAppear {
                // Show launch screen for 2 seconds, then fade out
                Task {
                    try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds

                    // Fade out launch screen - wrap in withAnimation to ensure it animates
                    await MainActor.run {
                        withAnimation(.easeOut(duration: 0.5)) {
                            showLaunchScreen = false
                        }
                    }
                }
            }
        }
    }
}
