import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var currentIndex = 0
    @State private var opacity: Double = 1.0
    @State private var transitionID = UUID()
    @State private var audioPlayer: AVAudioPlayer?

    let affirmations = [
        "You are capable of amazing things",
        "Your potential is limitless",
        "You are worthy of love and happiness",
        "Every day is a fresh start",
        "You have the strength to overcome any challenge",
        "You are enough, just as you are",
        "Your dreams are valid and achievable",
        "You radiate positivity and confidence",
        "You are creating the life you deserve",
        "Believe in yourself and your abilities"
    ]

    // Convert affirmation text to filename (e.g., "You are capable" -> "YouAreCapable")
    private func fileNameFromText(_ text: String) -> String {
        let words = text.components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .map { $0.trimmingCharacters(in: CharacterSet.punctuationCharacters) }
            .filter { !$0.isEmpty }
            .map { $0.capitalized }
        return words.joined()
    }

    // Map affirmations to audio file names
    private var audioFileNames: [String] {
        affirmations.map { fileNameFromText($0) }
    }

    @MainActor
    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }

    @MainActor
    private func playAffirmation() {
        // Configure audio session to ensure sound plays
        configureAudioSession()

        // Stop any currently playing audio
        audioPlayer?.stop()
        audioPlayer = nil

        // Get the audio file name for current affirmation
        let fileName = audioFileNames[currentIndex]

        // Try to find the audio file in Resources folder, then fallback to bundle root
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3", subdirectory: "Resources") ??
                  Bundle.main.url(forResource: fileName, withExtension: "m4a", subdirectory: "Resources") ??
                  Bundle.main.url(forResource: fileName, withExtension: "wav", subdirectory: "Resources") ??
                  Bundle.main.url(forResource: fileName, withExtension: "mp3") ??
                  Bundle.main.url(forResource: fileName, withExtension: "m4a") ??
                  Bundle.main.url(forResource: fileName, withExtension: "wav")

        guard let url = url else {
            print("Audio file not found: \(fileName)")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            audioPlayer = player
        } catch {
            print("Failed to play audio: \(error)")
        }
    }

    @MainActor
    private func advanceToNext() {
        // Generate new transition ID to invalidate any pending transitions
        let thisTransitionID = UUID()
        transitionID = thisTransitionID

        // Immediately stop any currently playing audio
        audioPlayer?.stop()
        audioPlayer = nil

        // Immediately fade out and change
        withAnimation(.easeInOut(duration: 0.3)) {
            opacity = 0.0
        }

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 300_000_000) // Wait for fade out

            // Check if this transition is still valid (user hasn't tapped again)
            guard transitionID == thisTransitionID else { return }

            currentIndex = (currentIndex + 1) % affirmations.count
            withAnimation(.easeInOut(duration: 0.3)) {
                opacity = 1.0
            }
            // Play the new affirmation after it appears
            playAffirmation()
        }
    }

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())

            Text(affirmations[currentIndex])
                .id(currentIndex) // Force SwiftUI to treat as new view when index changes
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
                .opacity(opacity)
                .animation(.easeInOut(duration: 0.3), value: opacity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            Task { @MainActor in
                advanceToNext()
            }
        }
        .onAppear {
            // Configure audio session when view appears
            Task { @MainActor in
                configureAudioSession()
                // Play the first affirmation when the view appears
                playAffirmation()
            }
        }
    }
}

#Preview {
    ContentView()
}
