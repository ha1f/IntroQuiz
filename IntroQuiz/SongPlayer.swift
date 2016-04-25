//
//  SongPlayer.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import AVFoundation

class SongPlayer {
    
    static let FADE_POWER: Float = 0.05
    
    private var player: AVPlayer = AVPlayer()
    private var fadeTimer: NSTimer?
    private var _isPausing: Bool = true
    var isPausing: Bool {
        return _isPausing
    }
    
    func setUrl(urlString: String) {
        player.replaceCurrentItemWithPlayerItem(AVPlayerItem(asset: AVAsset(URL: NSURL(string: urlString)!)))
        
        seekTo(0)
        _isPausing = true
    }
    
    func setVolume(volume: Float) {
        player.volume = Util.restrectedValue(volume, min: 0.0, max: 1.0)
    }
    
    func fadeOut() {
        fadeTimer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(decresc), userInfo: nil, repeats: true)
    }
    
    @objc private func decresc() {
        let currentVolume = player.volume
        if currentVolume > SongPlayer.FADE_POWER {
            player.volume = currentVolume - SongPlayer.FADE_POWER
        } else {
            fadeTimer?.invalidate()
            player.pause()
        }
    }
    
    func setSong(song: Song) {
        let urlString = song.previewUrl
        setUrl(urlString)
    }
    
    func seekTo(seconds: Double) {
        player.seekToTime(CMTime(seconds: seconds*10, preferredTimescale: 10))
    }
    
    func getProgress() -> Double {
        guard let duration = player.currentItem?.duration else {
            return 0.0
        }
        let currentTime = player.currentTime()
        return currentTime.seconds / duration.seconds
    }
    
    func play() {
        player.play()
        _isPausing = false
    }
    
    func pause() {
        player.pause()
        _isPausing = true
    }
    
    func currentTime() -> Double {
        return player.currentTime().seconds ?? 0.0
    }
    
}