//
//  ModelManager.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/24.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

class ModelManager {
    static let manager = ModelManager()
    
    let songRepository = SongRepository()
    
    let songPlayer = SongPlayer()
    
}