//
//  Vocabulary.swift
//  PronounceHero
//
//  Created by Saiday on 8/15/15.
//  Copyright © 2015 Stan. All rights reserved.
//

import Foundation

struct Vocabulary {
    let name: String
    let filePath: String
    
    init(name: String, filePath: String) {
        self.name = name
        self.filePath = filePath
    }
}