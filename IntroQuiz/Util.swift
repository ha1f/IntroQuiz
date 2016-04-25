//
//  Util.swift
//  IntroQuiz
//
//  Created by 山口智生 on 2016/04/20.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

class Util {
    static func restrectedValue<T: Comparable>(value: T, min minValue: T, max maxValue: T) -> T {
        return value < minValue ? minValue : min(value, maxValue)
    }
}
