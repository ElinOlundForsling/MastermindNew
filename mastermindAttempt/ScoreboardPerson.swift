//
//  ScoreboardPerson.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-10.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import Foundation

class ScoreboardPerson : Codable {
    var name : String
    var score : Int
    
    init(name : String, score : Int) {
        self.name = name
        self.score = score
    }
}
