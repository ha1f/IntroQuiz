//
//  PlayMusicViewController.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/24.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit
import Social
import WebImage

class PlaySongViewController: UIViewController {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    let player: SongPlayer = ModelManager.manager.songPlayer
    var song: Song! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Player"
        
        artworkImageView.sd_setImageWithURL(NSURL(string: song.artwork100Url))
        
        player.delegate = self
        player.setUrl(song.previewUrl)
        player.setVolume(1.0)
        player.play()
    }
    
    override func viewWillDisappear(animated: Bool) {
        player.fadeOut()
        super.viewWillDisappear(animated)
    }
    
    func dismiss() {
        navigationController?.popViewControllerAnimated(true)
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tappedPlayPauseButton(sender: AnyObject) {
        if player.isPausing {
            player.play()
        } else {
            player.pause()
        }
    }
    
    @IBAction func tappedShareButton(sender: AnyObject) {
        
        let postTwiterView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)

        postTwiterView.setInitialText("Now playing\n\"\(song.trackName)\" / \(song.artistName)\n\nLet's try on\n\(song.previewUrl)")
        //postTwiterView.addImage(artworkImageView.image)
        navigationController?.presentViewController(postTwiterView, animated: true, completion: nil)
    }
    
    
}

extension PlaySongViewController: SongPlayerDelegate {
    func songPlayerDidFinishedPlaying(songPlayer: SongPlayer) {
        dismiss()
    }
    
    func songPlayerPausingStatusDidChange(songPlayer: SongPlayer) {
        if songPlayer.isPausing {
            playPauseButton.setTitle("Play", forState: .Normal)
        } else {
            playPauseButton.setTitle("Pause", forState: .Normal)
        }
    }
}