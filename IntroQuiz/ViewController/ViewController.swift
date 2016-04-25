//
//  ViewController.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let songRepository = ModelManager.manager.songRepository
    
    @IBOutlet weak var songsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songRepository.fetchSongsWithTerm("sekai"){[unowned self] songs in
            self.songsTableView.reloadData()
        }
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
        songsTableView.contentOffset = CGPoint(x: 0.0, y: 0.0)
        
        title = "Songs"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSong(song: Song) {
        let storyboard = UIStoryboard(name: "PlaySongView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! PlaySongViewController
        controller.song = song
        self.navigationController?.pushViewController(controller, animated: true)
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
}

