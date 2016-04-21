//
//  SongPlayer.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import AVFoundation

class SongPlayer {
    var player: AVPlayer?
    var song: Song?
    
    var _isPausing: Bool = true
    var isPausing: Bool {
        return _isPausing
    }
    
    init() {

    }
    
    func setSong(song: Song) {
        self.song = song

        let url =  NSURL(string: song.previewUrl)!
        player = AVPlayer(URL: url)
        
        seekTo(0)
        _isPausing = true
    }
    
    func seekTo(seconds: Double) {
        player?.seekToTime(CMTime(seconds: seconds/60, preferredTimescale: 60))
    }
    
    func getProgress() -> Double? {
        guard let duration = player?.currentItem?.duration, currentTime = player?.currentTime() else {
            return nil
        }
        return currentTime.seconds / duration.seconds
    }
    
    func play() {
        player?.play()
        _isPausing = false
    }
    
    func pause() {
        player?.pause()
        _isPausing = true
    }
    
    func currentTime() -> Double? {
        return player?.currentTime().seconds
    }
}