//
//  Playlist.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

class Playlist {
    fileprivate var songs: [Song] = []
    
    func append(_ song: Song) {
        songs.append(song)
    }
    
    func insert(_ song: Song, index: Int) {
        songs.insert(song, at: index)
    }
    
    func removeAtIndex(_ index: Int) {
        songs.remove(at: index)
    }
}
