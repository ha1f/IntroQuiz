//
//  ItunesApi.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct ApiClient {
    let uri: String
    let header: [String: String]?
    
    init(uri: String) {
        self.uri = uri
        self.header = nil
    }
    
    init(uri: String, header: [String: String]) {
        self.uri = uri
        self.header = header
    }
    
    func get(params: [String: String], completionHandler: JSON? -> Void) {
        request(.GET, uri, parameters: params, encoding: .URL, headers: header)
            .responseJSON { response in
                if let data = response.result.value {
                    completionHandler(JSON(data))
                } else {
                    completionHandler(nil)
                }
            }
    }
    
    func post(params: [String: String], completionHandler: JSON? -> Void) {
        request(.POST, uri, parameters: params, encoding: .URL, headers: header)
            .responseJSON{ response in
                if let data = response.result.value {
                    completionHandler(JSON(data))
                } else {
                    completionHandler(nil)
                }
        }
    }
}

class ItunesApi {
    static let DOMAIN = "http://ax.itunes.apple.com"
    static let URI = DOMAIN + "/WebObjects/MZStoreServices.woa/wa/wsSearch"
    
    static let client = ApiClient(uri: URI)
    
    static func fetchSongsWithTerm(term: String, completion completionHandler: (songs: [Song]?) -> ()) {
        let params = ["term": term, "country": "JP", "entity": "musicTrack"]
        
        client.get(params) { json in
            if let trackJsons = json?["results"].array {
                let songs = trackJsons.map({trackJson in
                    Song(songJson: trackJson)
                })
                completionHandler(songs: songs)
            } else {
                completionHandler(songs: nil)
            }
        }
    }
}