//
//  AquaProgressBar.swift
//  OS X 10.4 Emu
//
//  Created by Josiah on 6/2/25.
//


import SwiftUI

struct AquaProgressBar: View {
    var progress: CGFloat // 0.0 to 1.0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Background Track
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.gray.opacity(0.4),
                                Color.gray.opacity(0.6)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )

                // Filled portion with stripes
                if progress > 0 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.45, green: 0.72, blue: 0.98),
                                        Color(red: 0.2, green: 0.5, blue: 0.9)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )

                        BarberPoleStripe()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(width: geo.size.width * progress)
                    .animation(.easeOut(duration: 0.3), value: progress)
                }
            }
        }
        .frame(height: 16)
    }
}

struct BarberPoleStripe: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let stripeWidth: CGFloat = 20
            let spacing: CGFloat = 12
            let count = Int((geo.size.width + stripeWidth * 2) / (stripeWidth + spacing))

            HStack(spacing: spacing) {
                ForEach(0..<count, id: \.self) { _ in
                    Rectangle()
                        .fill(Color.white.opacity(0.25))
                        .rotationEffect(.degrees(45))
                        .frame(width: stripeWidth, height: geo.size.height * 2)
                }
            }
            .offset(x: offset)
            .onAppear {
                offset = 0
                withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    offset = -stripeWidth - spacing
                }
            }
        }
    }
}
