//
//  Question.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/10.
//

import Foundation
import UIKit

struct Question {
    var title: String
    var options: [Option]
    var answer: Option
}

struct Option {
    var name: String
    var content: String = ""
}
