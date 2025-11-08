#!/usr/bin/env swift

import Foundation

let voices = {
    "Juniper": "aMSt68OGf4xUZAnLpTU8"
}

// Configuration - Update these with your ElevenLabs API key and voice ID
let ELEVENLABS_API_KEY = "YOUR_API_KEY_HERE"
let ELEVENLABS_VOICE_ID = voices["Juniper"] // e.g., "21m00Tcm4TlvDq8ikWAM" for Rachel
let OUTPUT_DIR = "Hype/Resources"

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

func generateAudio(text: String) async throws -> Data {
    let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(ELEVENLABS_VOICE_ID)")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue(ELEVENLABS_API_KEY, forHTTPHeaderField: "xi-api-key")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let requestBody: [String: Any] = [
        "text": text,
        "model_id": "eleven_monolingual_v1",
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

func fileNameFromText(_ text: String) -> String {
    // Convert "You are capable of amazing things" -> "YouAreCapableOfAmazingThings"
    let words = text.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        .map { $0.trimmingCharacters(in: CharacterSet.punctuationCharacters) }
        .filter { !$0.isEmpty }
        .map { $0.capitalized }
    return words.joined()
}

func saveAudioFile(data: Data, text: String) throws {
    let fileManager = FileManager.default
    let currentDir = fileManager.currentDirectoryPath
    let resourcesDir = (currentDir as NSString).appendingPathComponent(OUTPUT_DIR)

    // Create Resources directory if it doesn't exist
    if !fileManager.fileExists(atPath: resourcesDir) {
        try fileManager.createDirectory(atPath: resourcesDir, withIntermediateDirectories: true)
    }

    let fileName = "\(fileNameFromText(text)).mp3"
    let filePath = (resourcesDir as NSString).appendingPathComponent(fileName)

    try data.write(to: URL(fileURLWithPath: filePath))
    print("✓ Saved: \(fileName)")
}

@MainActor
func main() async {
    // Check if API key is set
    if ELEVENLABS_API_KEY == "YOUR_API_KEY_HERE" {
        print("❌ Error: Please set ELEVENLABS_API_KEY in the script")
        exit(1)
    }

    if ELEVENLABS_VOICE_ID == "YOUR_VOICE_ID_HERE" {
        print("❌ Error: Please set ELEVENLABS_VOICE_ID in the script")
        exit(1)
    }

    print("🎙️  Generating audio files from ElevenLabs...")
    print("📝 Found \(affirmations.count) affirmations\n")

    for (index, affirmation) in affirmations.enumerated() {
        print("[\(index + 1)/\(affirmations.count)] Generating: \"\(affirmation)\"")

        do {
            let audioData = try await generateAudio(text: affirmation)
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
