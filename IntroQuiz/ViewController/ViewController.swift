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
    
    func searchSongs(_ term: String) {
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
    
    func playSong(_ song: Song) {
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
    
    @IBAction func tappedShareButton(_ sender: AnyObject) {
        guard let song = currentSongView.song else {
            return
        }
        
        let postTwiterView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        postTwiterView?.setInitialText("Now playing\n\"\(song.trackName)\" / \(song.artistName)\n\nLet's try on\n\(song.previewUrl)")
        //postTwiterView.addImage(artworkImageView.image)
        navigationController?.present(postTwiterView!, animated: true, completion: nil)
    }
    
    @IBAction func tappedPlayPauseButton(_ sender: AnyObject) {
        if player.isPausing {
            player.play()
        } else {
            player.pause()
        }
    }
}

extension ViewController: SongPlayerDelegate {
    func songPlayerDidFinishedPlaying(_ songPlayer: SongPlayer) {
        player.pause()
        player.seekTo(0)
    }
    
    func songPlayerPausingStatusDidChange(_ songPlayer: SongPlayer) {
        if songPlayer.isPausing {
            currentSongView.playPauseButton.setTitle("Play", for: UIControlState())
        } else {
            currentSongView.playPauseButton.setTitle("Pause", for: UIControlState())
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSongs(searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongsTableViewCell") as! SongsTableViewCell
        cell.setSong(self.songRepository.songs[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songRepository.songs.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playSong(self.songRepository.songs[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
