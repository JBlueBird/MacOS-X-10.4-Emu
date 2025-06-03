//
//  Styles.swift
//  OS X 10.4 Emu
//
//  Created by Josiah on 6/2/25.
//
import SwiftUI

struct AquaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: configuration.isPressed ?
                                    [Color(red: 0.2, green: 0.5, blue: 1.0),
                                     Color(red: 0.1, green: 0.3, blue: 0.8)] :
                                    [Color(red: 0.5, green: 0.75, blue: 1.0),
                                     Color(red: 0.2, green: 0.5, blue: 1.0)]
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                    // Glossy overlay
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(configuration.isPressed ? 0.1 : 0.35),
                                    Color.white.opacity(0)
                                ]),
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: .black.opacity(configuration.isPressed ? 0.1 : 0.3),
                    radius: configuration.isPressed ? 1 : 3, y: configuration.isPressed ? 1 : 3)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct ClearWhiteAquaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black.opacity(configuration.isPressed ? 0.6 : 0.8))
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(configuration.isPressed ? 0.7 : 0.9),
                                    Color.white.opacity(0.4)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                    // Top glossy sheen
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.5),
                                    Color.clear
                                ]),
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: .black.opacity(configuration.isPressed ? 0.05 : 0.15),
                    radius: configuration.isPressed ? 1 : 2, y: configuration.isPressed ? 0 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}


struct AquaTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(
                ZStack {
                    // Outer rounded border
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white,
                                    Color(red: 0.95, green: 0.95, blue: 0.98)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(
                                    Color(red: 0.7, green: 0.75, blue: 0.85),
                                    lineWidth: 1
                                )
                        )
                    
                    // Inner glossy overlay
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.7),
                                    Color.clear
                                ]),
                                startPoint: .top,
                                endPoint: .center
                            ),
                            lineWidth: 1
                        )
                        .blendMode(.overlay)
                }
            )
            .font(.system(size: 14))
    }
}

struct AquaIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.black.opacity(configuration.isPressed ? 0.5 : 0.8))
            .frame(width: 30, height: 28)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white,
                                    Color(red: 0.95, green: 0.95, blue: 0.98)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(red: 0.7, green: 0.75, blue: 0.85), lineWidth: 1)
                        )
                    
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.5),
                                    Color.clear
                                ]),
                                startPoint: .top,
                                endPoint: .center
                            ),
                            lineWidth: 1
                        )
                        .blendMode(.overlay)
                }
            )
            .shadow(color: .black.opacity(0.1),
                    radius: configuration.isPressed ? 1 : 2, y: configuration.isPressed ? 0 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
