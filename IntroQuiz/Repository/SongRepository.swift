//
//  SongRepository.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/24.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation



class SongRepository {
    private var _songs: [Song] = []
    var songs: [Song] {
        return _songs
    }
    
    func fetchSongsWithTerm(term: String, completion: ([Song]) -> ()) {
        if _songs.isEmpty {
            ItunesApi.fetchSongsWithTerm(term){[unowned self] songs in
                self._songs = songs
                completion(self._songs)
            }
        } else {
            completion(_songs)
        }
    }
    
    func clear() {
        _songs = []
    }
}