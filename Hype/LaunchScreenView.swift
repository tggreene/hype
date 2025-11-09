import SwiftUI

struct LaunchScreenView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // Background - white in light mode, black in dark mode
            (colorScheme == .light ? Color.white : Color.black)
                .ignoresSafeArea()

            // App name or logo - black text in light mode, white in dark mode
            VStack(spacing: 20) {
                Text("Hype")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .foregroundColor(colorScheme == .light ? .black : .white)
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
