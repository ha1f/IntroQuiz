//
//  Song.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import SwiftyJSON

struct Song {
    var artistName: String
    var trackName: String
    var releaseDate: String
    
    var artworkUrl: String
    
    var trackTimeMillis: Int
    var primaryGenreName: String
    
    var previewUrl: String
    var collectionName: String
    
    init(songJson: JSON) {
        artistName = songJson["artistName"].string ?? ""
        trackName = songJson["trackCensoredName"].string ?? ""
        releaseDate = songJson["releaseDate"].string ?? ""
        
        artworkUrl = songJson["artworkUrl60"].string ?? ""
        
        trackTimeMillis = songJson["trackTimeMillis"].int ?? 0
        primaryGenreName = songJson["primaryGenreName"].string ?? ""
        
        previewUrl = songJson["previewUrl"].string ?? ""
        collectionName = songJson["collectionCensoredName"].string ?? ""
    }
}

/*
 {
 artistId = 454694621;
 artistName = "SEKAI NO OWARI";
 artistViewUrl = "https://itunes.apple.com/jp/artist/sekai-no-owari/id454694621?uo=4";
 artworkUrl100 = "http://is3.mzstatic.com/image/thumb/Music3/v4/f7/62/da/f762dac5-83f3-a4bb-0e95-1dda7029115c/source/100x100bb.jpg";
 artworkUrl30 = "http://is3.mzstatic.com/image/thumb/Music3/v4/f7/62/da/f762dac5-83f3-a4bb-0e95-1dda7029115c/source/30x30bb.jpg";
 artworkUrl60 = "http://is3.mzstatic.com/image/thumb/Music3/v4/f7/62/da/f762dac5-83f3-a4bb-0e95-1dda7029115c/source/60x60bb.jpg";
 collectionCensoredName = "Dragon Night - Single";
 collectionExplicitness = notExplicit;
 collectionId = 925252932;
 collectionName = "Dragon Night - Single";
 collectionPrice = 750;
 collectionViewUrl = "https://itunes.apple.com/jp/album/dragon-night/id925252932?i=925252943&uo=4";
 country = JPN;
 currency = JPY;
 discCount = 1;
 discNumber = 1;
 isStreamable = 0;
 kind = song;
 previewUrl = "http://a407.phobos.apple.com/us/r20/Music3/v4/e6/2e/19/e62e1987-3add-ceed-37ba-beadc84aa16c/mzaf_8316994434485171788.plus.aac.p.m4a";
 primaryGenreName = "J-Pop";
 releaseDate = "2014-10-15T07:00:00Z";
 trackCensoredName = "Dragon Night";
 trackCount = 3;
 trackExplicitness = notExplicit;
 trackId = 925252943;
 trackName = "Dragon Night";
 trackNumber = 1;
 trackPrice = 250;
 trackTimeMillis = 231107;
 trackViewUrl = "https://itunes.apple.com/jp/album/dragon-night/id925252932?i=925252943&uo=4";
 wrapperType = track;
 }
 */