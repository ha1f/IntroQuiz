//
//  SongRepository.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/24.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

class SongRepository {
    fileprivate var _songs: [Song] = []
    var songs: [Song] {
        return _songs
    }
    
    func replaceSongsWithTerm(_ term: String, completion: @escaping () -> ()) {
        ItunesApi.fetchSongsWithTerm(term){[weak self] songs in
            guard let `self` = self else {
                return
            }
            if let songs = songs {
                self._songs = songs
            }
            completion()
        }
    }
    
    func fetchSongsWithTerm(_ term: String, completion: @escaping () -> ()) {
        if _songs.isEmpty {
            ItunesApi.fetchSongsWithTerm(term){[weak self] songs in
                guard let `self` = self else {
                    return
                }
                if let songs = songs {
                    self._songs = songs
                    completion()
                } else {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    func clear() {
        _songs = []
    }
}
