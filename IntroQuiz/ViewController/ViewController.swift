//
//  ViewController.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    let songRepository = ModelManager.manager.songRepository
    
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currentSongView: CurrentSongView!
    
    let player = ModelManager.manager.songPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        
        songRepository.fetchSongsWithTerm("sekai"){[weak self] _ in
            guard let `self` = self else {
                return
            }
            self.songsTableView.reloadData()
        }
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
        songsTableView.contentOffset = CGPoint(x: 0.0, y: 0.0)
        
        searchBar.delegate = self
        player.delegate = self
        player.setVolume(1.0)
    }
    
    func searchSongs(term: String) {
        songRepository.replaceSongsWithTerm(term){[weak self] _ in
            guard let `self` = self else {
                return
            }
            self.songsTableView.reloadData()
            self.searchBar.resignFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSong(song: Song) {
        // let storyboard = UIStoryboard(name: "PlaySongView", bundle: nil)
        // let controller = storyboard.instantiateInitialViewController() as! PlaySongViewController
        // controller.song = song
        // self.navigationController?.pushViewController(controller, animated: true)
        
        if currentSongView.song?.previewUrl == song.previewUrl {
            return
        }
        currentSongView.setSong(song)
        player.setUrl(song.previewUrl)
        player.play()
    }
    
    @IBAction func tappedShareButton(sender: AnyObject) {
        guard let song = currentSongView.song else {
            return
        }
        
        let postTwiterView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        postTwiterView.setInitialText("Now playing\n\"\(song.trackName)\" / \(song.artistName)\n\nLet's try on\n\(song.previewUrl)")
        //postTwiterView.addImage(artworkImageView.image)
        navigationController?.presentViewController(postTwiterView, animated: true, completion: nil)
    }
    
    @IBAction func tappedPlayPauseButton(sender: AnyObject) {
        if player.isPausing {
            player.play()
        } else {
            player.pause()
        }
    }
}

extension ViewController: SongPlayerDelegate {
    func songPlayerDidFinishedPlaying(songPlayer: SongPlayer) {
        player.pause()
        player.seekTo(0)
    }
    
    func songPlayerPausingStatusDidChange(songPlayer: SongPlayer) {
        if songPlayer.isPausing {
            currentSongView.playPauseButton.setTitle("Play", forState: .Normal)
        } else {
            currentSongView.playPauseButton.setTitle("Pause", forState: .Normal)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSongs(searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongsTableViewCell") as! SongsTableViewCell
        cell.setSong(self.songRepository.songs[indexPath.row])
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songRepository.songs.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        playSong(self.songRepository.songs[indexPath.row])
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
