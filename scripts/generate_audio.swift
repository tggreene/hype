#!/usr/bin/env swift

import Foundation

let voices = [
    "Juniper": "aMSt68OGf4xUZAnLpTU8"
]

let OUTPUT_DIR = "Hype/Resources"

// Get API key from environment variable
let ELEVENLABS_API_KEY = ProcessInfo.processInfo.environment["ELEVENLABS_API_KEY"]
let ELEVENLABS_VOICE_ID = voices["Juniper"] ?? ""

let affirmations = [
    "You are a majestic beast",
    // "You are capable of amazing things",
    // "Your potential is limitless",
    // "You are worthy of love and happiness",
    // "Every day is a fresh start",
    // "You have the strength to overcome any challenge",
    // "You are enough, just as you are",
    // "Your dreams are valid and achievable",
    // "You radiate positivity and confidence",
    // "You are creating the life you deserve",
    // "Believe in yourself and your abilities"
]

func generateAudio(text: String, apiKey: String, voiceID: String) async throws -> Data {
    let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(voiceID)")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue(apiKey, forHTTPHeaderField: "xi-api-key")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let requestBody: [String: Any] = [
        "text": text,
        "model_id": "eleven_multilingual_v2",
        "voice_settings": [
            "stability": 0.5,
            "similarity_boost": 0.75
        ]
    ]

    request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
        throw NSError(domain: "AudioGeneration", code: -1,
                     userInfo: [NSLocalizedDescriptionKey: "Failed to generate audio: \(errorMessage)"])
    }

    return data
}

func saveAudioFile(data: Data, text: String) throws {
    let fileManager = FileManager.default
    // Script should be run from project root, so current directory is project root
    let currentDir = fileManager.currentDirectoryPath
    let resourcesDir = (currentDir as NSString).appendingPathComponent(OUTPUT_DIR)

    // Create Resources directory if it doesn't exist
    if !fileManager.fileExists(atPath: resourcesDir) {
        try fileManager.createDirectory(atPath: resourcesDir, withIntermediateDirectories: true)
    }

    // Use the affirmation text directly as the filename
    let fileName = "\(text).mp3"
    let filePath = (resourcesDir as NSString).appendingPathComponent(fileName)

    try data.write(to: URL(fileURLWithPath: filePath))
    print("✓ Saved: \(fileName)")
}

@MainActor
func main() async {
    // Check if API key is set
    guard let apiKey = ELEVENLABS_API_KEY, !apiKey.isEmpty else {
        print("❌ Error: ElevenLabs API key not found!")
        print("\nPlease set it as an environment variable:")
        print("  export ELEVENLABS_API_KEY='your-key-here'")
        exit(1)
    }

    guard !ELEVENLABS_VOICE_ID.isEmpty else {
        print("❌ Error: Voice ID not found")
        exit(1)
    }

    print("🎙️  Generating audio files from ElevenLabs...")
    print("📝 Found \(affirmations.count) affirmations\n")

    for (index, affirmation) in affirmations.enumerated() {
        print("[\(index + 1)/\(affirmations.count)] Generating: \"\(affirmation)\"")

        do {
            let audioData = try await generateAudio(text: affirmation, apiKey: apiKey, voiceID: ELEVENLABS_VOICE_ID)
            try saveAudioFile(data: audioData, text: affirmation)

            // Small delay to avoid rate limiting
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        } catch {
            print("❌ Error generating audio for affirmation \(index): \(error.localizedDescription)")
            exit(1)
        }
    }

    print("\n✅ All audio files generated successfully!")
    print("📁 Files saved to: \(OUTPUT_DIR)")
}

Task {
    await main()
    exit(0)
}

RunLoop.main.run()
