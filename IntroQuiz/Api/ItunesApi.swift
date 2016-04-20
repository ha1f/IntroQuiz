//
//  ItunesApi.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ItunesApi {
    static let DOMAIN = "http://ax.itunes.apple.com"
    static let URI = DOMAIN + "/WebObjects/MZStoreServices.woa/wa/wsSearch"
    
    private static func request(params: [String: String], handler: (JSON) -> ()) {
        Alamofire.request(.GET, URI, parameters: params, encoding: .URL)
            .responseJSON { response in
                guard let data = response.result.value else {
                    return
                }
                handler(JSON(data))
        }
    }
    
    static func fetchSongsWithTerm(term: String, completion: (songs: [Song]) -> ()) {
        let params = ["term": term, "country": "JP", "entity": "musicTrack"]
        
        request(params) { json in
            guard let trackJsons = json["results"].array else {
                return
            }
            let songs = trackJsons.map({trackJson in
                Song(songJson: trackJson)
            })
            completion(songs: songs)
        }
    }
}