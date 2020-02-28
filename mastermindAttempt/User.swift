//
//  User.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-15.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import Foundation

class User : Codable {
    var name : String
    var score : Int
    var streak : Int
    var activeRow : Int
    var guessBoard : [Int]
    var currentGuess : [Int]
    var dotBoard : [Int]
    var solution : [Int]
    
    init(name : String, score : Int, streak : Int, activeRow : Int, guessBoard : [Int], currentGuess : [Int], dotBoard : [Int], solution : [Int]) {
        self.name = name
        self.score = score
        self.streak = streak
        self.activeRow = activeRow
        self.guessBoard = guessBoard
        self.currentGuess = currentGuess
        self.dotBoard = dotBoard
        self.solution = solution
    }
    
    init() {
        self.name = "Name here"
        self.score = 0
        self.streak = 0
        self.activeRow = 9
        self.guessBoard = Array(repeating: 0, count: 40)
        self.currentGuess = Array(repeating: 0, count: 4)
        self.dotBoard = Array(repeating: 0, count: 40)
        self.solution = Array(repeating: 0, count: 4)
    }
}
