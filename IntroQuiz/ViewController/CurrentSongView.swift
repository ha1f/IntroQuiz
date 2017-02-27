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
    
    func setSong(_ song: Song) {
        self.song = song
        
        artworkImageView.sd_setImage(with: URL(string: song.artworkUrl))
        artworkImageView.isHidden = false
        trackNameLabel.text = song.trackName
        trackNameLabel.isHidden = false
        artistNameLabel.text = song.artistName
        artistNameLabel.isHidden = false
        
        playPauseButton.isHidden = false
    }
}
