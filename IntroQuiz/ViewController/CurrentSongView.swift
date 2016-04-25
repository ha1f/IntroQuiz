//
//  CurrentSongView.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/25.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class CurrentSongView: UIView {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var song: Song? = nil
    
    func setSong(song: Song) {
        self.song = song
        
        artworkImageView.sd_setImageWithURL(NSURL(string: song.artworkUrl))
        artworkImageView.hidden = false
        trackNameLabel.text = song.trackName
        trackNameLabel.hidden = false
        artistNameLabel.text = song.artistName
        artistNameLabel.hidden = false
        
        playPauseButton.hidden = false
    }
}
