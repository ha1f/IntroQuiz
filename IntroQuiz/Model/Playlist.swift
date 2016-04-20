//
//  Playlist.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

class Playlist {
    private var songs: [Song] = []
    
    func append(song: Song) {
        songs.append(song)
    }
    
    func insert(song: Song, index: Int) {
        songs.insert(song, atIndex: index)
    }
    
    func removeAtIndex(index: Int) {
        songs.removeAtIndex(index)
    }
}
