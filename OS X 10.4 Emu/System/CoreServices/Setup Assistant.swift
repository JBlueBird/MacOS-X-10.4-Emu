//
//  ContentView.swift
//  OS X 10.4 Emu
//
//  Created by Josiah on 6/2/25.
//
import SwiftUI
import AVKit
import AVFoundation

struct VideoPlayerView: NSViewRepresentable {
    let player: AVPlayer

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        view.layer = playerLayer
        view.wantsLayer = true
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        if let playerLayer = nsView.layer as? AVPlayerLayer {
            playerLayer.player = player
        }
    }
}

struct ContentView: View {
    @State private var videoPlayer: AVPlayer?
    @State private var audioPlayer: AVPlayer?
    @State private var videoFinished = true //Change to false to watch the intro video

    var body: some View {
        ZStack {
            if videoFinished {
                ty_setup()
            } else if let videoPlayer = videoPlayer {
                VideoPlayerView(player: videoPlayer)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                    .onAppear {
                        setupAndPlay()
                    }
            }
        }
    }

    func setupAndPlay() {
        guard let videoURL = Bundle.main.url(forResource: "intro", withExtension: "mov"),
              let audioURL = Bundle.main.url(forResource: "intro-sound", withExtension: "mp3") else {
            print("Error: Could not find media files in bundle.")
            return
        }

        let vp = AVPlayer(url: videoURL)
        let ap = AVPlayer(url: audioURL)

        vp.currentItem?.preferredForwardBufferDuration = 10.0
        ap.currentItem?.preferredForwardBufferDuration = 10.0

        videoPlayer = vp
        audioPlayer = ap

        // Add observer for video finished notification
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: vp.currentItem,
                                               queue: .main) { _ in
            // When video finishes, switch UI but keep audio playing
            videoFinished = true
        }

        // Wait until video asset is playable, then start playback
        vp.currentItem?.asset.loadValuesAsynchronously(forKeys: ["playable"]) {
            DispatchQueue.main.async {
                let status = vp.currentItem?.asset.statusOfValue(forKey: "playable", error: nil)
                if status == .loaded {
                    let startTime = CMTime(seconds: 0, preferredTimescale: 1)
                    vp.seek(to: startTime)
                    ap.seek(to: startTime)
                    vp.play()
                    ap.play()
                    addSyncObserver()
                }
            }
        }
    }

    func addSyncObserver() {
        guard let videoPlayer = videoPlayer, let audioPlayer = audioPlayer else { return }
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        _ = videoPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let audioTime = audioPlayer.currentTime()
            let diffSeconds = CMTimeGetSeconds(time) - CMTimeGetSeconds(audioTime)
            if abs(diffSeconds) > 0.5 {
                audioPlayer.seek(to: time)
            }
        }
    }
}
