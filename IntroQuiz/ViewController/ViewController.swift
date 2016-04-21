//
//  ViewController.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // なぜかローカル変数だと再生されない
    var player: SongPlayer = SongPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ItunesApi.fetchSongsWithTerm("sekai"){[unowned self] songs in
            for song in songs {
                print(song.trackName)
            }
            self.player.setSong(songs.first!)
            self.player.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

