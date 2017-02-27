//
//  SongPlayer.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import AVFoundation

protocol SongPlayerDelegate {
    func songPlayerDidFinishedPlaying(_ songPlayer: SongPlayer)
    func songPlayerPausingStatusDidChange(_ songPlayer: SongPlayer)
}

class SongPlayer {
    
    static let FADE_POWER: Float = 0.05
    
    fileprivate var player: AVPlayer
    fileprivate var fadeTimer: Timer?
    fileprivate var _isPausing: Bool = true {
        didSet {
            delegate?.songPlayerPausingStatusDidChange(self)
        }
    }
    var isPausing: Bool {
        return _isPausing
    }
    
    var delegate: SongPlayerDelegate?
    
    init() {
        player = AVPlayer()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachedEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func reachedEnd() {
        delegate?.songPlayerDidFinishedPlaying(self)
    }
    
    func setUrl(_ urlString: String) {
        player.replaceCurrentItem(with: AVPlayerItem(asset: AVAsset(url: URL(string: urlString)!)))
        
        seekTo(0)
        _isPausing = true
    }
    
    func setVolume(_ volume: Float) {
        player.volume = Util.restrectedValue(volume, min: 0.0, max: 1.0)
    }
    
    func fadeOut() {
        fadeTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(decresc), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func decresc() {
        let currentVolume = player.volume
        if currentVolume > SongPlayer.FADE_POWER {
            player.volume = currentVolume - SongPlayer.FADE_POWER
        } else {
            fadeTimer?.invalidate()
            player.pause()
        }
    }
    
    func setSong(_ song: Song) {
        let urlString = song.previewUrl
        setUrl(urlString)
    }
    
    func seekTo(_ seconds: Double) {
        player.seek(to: CMTime(seconds: seconds*10, preferredTimescale: 10))
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
        return player.currentTime().seconds 
    }
    
}
