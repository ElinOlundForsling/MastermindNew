//
//  Mastermind.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-05.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


// MARK: PROTOCOL

protocol MastermindDelegate: class {
    func sendResult(white : Int, black : Int, activeRow : Int)
    func resetBoard(hasWon : Bool, streak : Int, score : Int, topScore : Int)
    func setInitialValues(name : String, score : Int, streak : Int, activeRow : Int, guessBoard : [Int], currentGuess : [Int], dotBoard : [Int])
}

class Mastermind {
    
    
    // MARK: START VARIABLES
    
    var db : Firestore!
    var auth : Auth!
    var user : User!
    
    
    weak var delegate : MastermindDelegate?
    var solution = Array(repeating: 0, count: 4)
    var white = 0
    var black = 0
    var gray = 0
    var streak = 0
    var score = 0
    var activeRow = 9
    var dotBoard = Array(repeating: 0, count: 40)
    
    
    // MARK: SIGN IN TO FIRESTORE
    
    func firestoreSignIn() {
        db = Firestore.firestore()
        auth = Auth.auth()
        
        Auth.auth().signInAnonymously() { (authResult, error) in
        }
        
        guard let user = auth.currentUser else { return }
        let statsRef = db.collection("users").document(user.uid)

        statsRef.getDocument { (document, error) in
            let result = Result {
                try document.flatMap {
                    try $0.data(as: User.self)
                }
            }
            switch result {
            case .success(let user):
                if let user = user {
                    DispatchQueue.main.async {
                        self.user = user
                        self.score = user.score
                        self.streak = user.streak
                        self.activeRow = user.activeRow
                        self.dotBoard = user.dotBoard
                        self.solution = user.solution
                    }
                    DispatchQueue.main.async {
                        self.delegate?.setInitialValues(name: user.name, score: user.score, streak: user.streak, activeRow: user.activeRow, guessBoard: user.guessBoard, currentGuess: user.currentGuess, dotBoard: user.dotBoard)
                    }
                    DispatchQueue.main.async {
                        if self.solution == [0, 0, 0, 0] {
                            self.makeSolution()
                        }
                    }
                    DispatchQueue.main.async {
                        self.firebaseUpdate()
                    }
                } else {
                    self.user = User()
                    self.makeSolution()
                    self.firebaseUpdate()
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
            }
        }
        
    }
    
    
    // MARK: UPDATE FIRESTORE
    
    func firebaseUpdate() {
        user.score = self.score
        user.streak = self.streak
        user.activeRow = self.activeRow
        user.dotBoard = self.dotBoard
        user.solution = self.solution
        do {
            try db.collection("users").document(auth.currentUser!.uid).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func firebaseNameUpdate(name : String) {
        user.name = name
        firebaseUpdate()
    }
    
    func firebaseGuessBoardUpdate(guessBoard : [Int], currentGuess : [Int]) {
        user.guessBoard = guessBoard
        user.currentGuess = currentGuess
        firebaseUpdate()
    }
    
    
    // MARK: MAKE SOLUTION
    
    func makeSolution() {
        for index in 0...3 {
            solution[index] = Int.random(in: 1...6)
        }
        firebaseUpdate()
        print(solution)
    }
    
    
    // MARK: CHECK SOLUTION
        
    func checkSolution(guess : [Int]) {
        
        white = 0
        black = 0
        var hasBeenChecked: [Bool] = [false, false, false, false]
            
        for i in 0...3 {
            if solution[i] == guess[i] {
                hasBeenChecked[i] = true
                black += 1
            }
        }

        for i in 0...3 {
            if solution[i] != guess[i] {
                for j in 0...3 {
                    if !hasBeenChecked[j] && j != i && guess[j] == solution[i] {
                        hasBeenChecked[j] = true
                        white += 1
                        break
                    }
                }
            }
        }
        
        
        // MARK: ADD TO DOT ARRAY
        var tempBlack = black
        var tempWhite = white
        for i in 0...3 {
            let number = i + (activeRow * 4)
            if tempBlack > 0 {
                dotBoard[number] = 1
                tempBlack -= 1
            } else if tempWhite > 0 {
                dotBoard[number] = 2
                tempWhite -= 1
            } else {
                dotBoard[number] = 0
            }
        }
        
        
        // MARK: SENDRESULT DELEGATE
        activeRow -= 1
        firebaseUpdate()
        delegate?.sendResult(white: white, black: black, activeRow : activeRow)
        if black == 4 {
            hasWon()
        } else if activeRow == -1 {
            hasLost()
        }
        gray = 4 - black - white
        
    }
    
        
    // MARK: WIN/LOSE
        
    func hasWon() {
        streak += 1
        let points = 2 + activeRow
        score += points
        resetModule()
        delegate?.resetBoard(hasWon : true, streak : streak, score : score, topScore : score)
    }
        
    func hasLost() {
        let topScore = score
        streak = 0
        score = 0
        resetModule()
        delegate?.resetBoard(hasWon : false, streak : streak, score : score, topScore : topScore)
    }
    
    func resetModule() {
        activeRow = 9
        let blankBoard = Array(repeating: 0, count: 40)
        let currentGuess = Array(repeating: 0, count: 4)
        dotBoard = blankBoard
        firebaseGuessBoardUpdate(guessBoard: blankBoard, currentGuess: currentGuess)
    }
}
