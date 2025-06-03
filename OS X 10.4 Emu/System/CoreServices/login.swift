//
//  login.swift
//  OS X 10.4 Emu
//
//  Created by Josiah on 6/2/25.
//

import SwiftUI
import AVFoundation

struct login: View {
    let password: String
    let username: String
    @State var usrn = ""
    @State var psswd = ""
    @State private var isSecure: Bool = true
    @FocusState private var fieldFocused: Bool

    // Boot chime player
    @State private var player: AVAudioPlayer?

    var body: some View {
        ZStack {
            // MARK: - Background
            Image("default")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // MARK: - Login Panel
            VStack(spacing: 22) {
                // Apple Logo
                Image(systemName: "applelogo")
                    .resizable()
                    .frame(width: 80, height: 100)

                // Name TextField
                TextField("Name", text: $usrn)
                    .textFieldStyle(AquaTextFieldStyle())
                    .frame(width: 260)
                    .focused($fieldFocused)

                // Password Field with Eye Toggle
                HStack(spacing: 4) {
                    if isSecure {
                        SecureField("Password", text: $psswd)
                            .textFieldStyle(AquaTextFieldStyle())
                    } else {
                        TextField("Password", text: $psswd)
                            .textFieldStyle(AquaTextFieldStyle())
                    }

                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                    }
                    .buttonStyle(AquaIconButtonStyle())
                }
                .frame(width: 260)
                .focused($fieldFocused)

                // Login Button
                Button("Log In") {
                    // Login action
                }
                .buttonStyle(AquaButtonStyle())
                .frame(width: 100)

                // Footer
                Text("© Apple Computer, Inc. 2005")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.vertical, 36)
            .padding(.horizontal, 48)
            .background(
                ZStack {
                    // Glass background
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.08))
                        .background(.ultraThinMaterial)

                    // Gloss reflection overlay
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                        .blur(radius: 1.0)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1.5)
            )
        }
        .onAppear {
            playBootChime()
        }
    }

    // MARK: - Play Boot Chime
    func playBootChime() {
        guard let soundURL = Bundle.main.url(forResource: "macos_chime", withExtension: "mp3") else {
            print("Chime sound not found.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
}
