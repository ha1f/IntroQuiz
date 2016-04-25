//
//  PlayMusicViewController.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/24.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class PlaySongViewController: UIViewController {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    let player: SongPlayer = ModelManager.manager.songPlayer
    var song: Song! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Player"
        
        artworkImageView.sd_setImageWithURL(NSURL(string: song.artwork100Url))
        
        player.setUrl(song.previewUrl)
        player.setVolume(2.0)
        player.play()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        player.fadeOut()
        super.viewWillDisappear(animated)
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pressedDismissButton() {
        dismiss()
    }
}