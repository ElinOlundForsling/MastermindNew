//
//  ViewController.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-01-24.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout

class GameplayViewController: UIViewController, GameplayViewDelegate, MastermindDelegate, ScoreboardViewControllerDelegate {
    
    let gameplayView = GameplayView(frame: .zero)
    let mastermind = Mastermind()
    let infoViewController : UIViewController = InfoViewController()
    let rulesViewController : UIViewController = RulesViewController()
    let scoreboardViewController : ScoreboardViewController = ScoreboardViewController()
    var name : String = "Name here"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: INITIAL LOAD
        
        DispatchQueue.main.async {
            self.title = "MASTERMIND"
            self.gameplayView.activeRow = self.mastermind.activeRow
            self.gameplayView.delegate = self
            self.mastermind.delegate = self
            self.scoreboardViewController.delegate = self
            self.view.addSubview(self.gameplayView)
            self.gameplayView.autoPinEdgesToSuperviewEdges()
            self.view.layoutIfNeeded()
        }
        
        DispatchQueue.main.async {
            self.mastermind.firestoreSignIn()
        }
    }
    
    // MARK: SET INITIAL VALUES
    func setInitialValues(name : String, score : Int, streak : Int, activeRow : Int, guessBoard : [Int], currentGuess : [Int], dotBoard : [Int]) {
        self.name = name
        gameplayView.updateLabels(streak: streak, score: score)
        gameplayView.activeRow = activeRow
        gameplayView.guessBoard = guessBoard
        gameplayView.updateBoard(guessboard: guessBoard, userGuess: currentGuess, dotboard: dotBoard)
        gameplayView.checkIfFull()
        mastermind.firebaseUpdate()
    }
    
    
    // MARK: SEND GUESS TO MODEL
    func sendGuess(userGuess : [Int]) {
        mastermind.checkSolution(guess: userGuess)
    }
    
    func sendBoard(guessBoard : [Int], currentGuess : [Int]) {
        mastermind.firebaseGuessBoardUpdate(guessBoard : guessBoard, currentGuess : currentGuess)
    }
    
    func sendResult(white: Int, black: Int, activeRow : Int) {
        gameplayView.updateDots(white: white, black: black)
        gameplayView.activeRow = activeRow
    }
    
    func resetBoard(hasWon : Bool, streak : Int, score : Int, topScore : Int) {
        
        DispatchQueue.main.async {
            self.gameplayView.activeRow = self.mastermind.activeRow
            self.mastermind.makeSolution()
            self.gameplayView.resetBoard(streak: streak, score: score)
        }
        
        DispatchQueue.main.async {
            self.mastermind.firebaseUpdate()
            hasWon ? self.showWinAlert(score : score) : self.showLoseAlert(score: topScore)
        }
        
    }
    
    lazy var transition: CATransition = {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        return transition
    }()
    
    func pressInfoButton() {
        self.view.window!.layer.add(transition, forKey: nil)
        infoViewController.modalPresentationStyle = .fullScreen
        self.present(infoViewController, animated: false, completion: nil)
    }
    
    func pressRulesButton() {
        self.view.window!.layer.add(transition, forKey: nil)
        rulesViewController.modalPresentationStyle = .fullScreen
        self.present(rulesViewController, animated: false, completion: nil)
    }
    
    func pressScoreboardButton() {
        self.view.window!.layer.add(transition, forKey: nil)
        scoreboardViewController.modalPresentationStyle = .fullScreen
        self.present(scoreboardViewController, animated: false, completion: nil)
    }
    
    func showWinAlert(score : Int) {
    
        let winAlert = UIAlertController(title: "You Won!", message: "Your score is now \(score)!", preferredStyle: .alert)
    
        let winAction = UIAlertAction(title: "Start next round", style: .default, handler: nil)
    
        winAlert.addAction(winAction)
    
        present(winAlert, animated: true, completion: nil)
    }
    
    func showLoseAlert(score : Int) {
    
        let loseAlert = UIAlertController(title: "Streak Broken!", message: "Better luck next time!", preferredStyle: .alert)
        let loseAction = UIAlertAction(title: "Start Over", style: .default, handler: {action in self.scoreboardViewController.checkIfQualify(score: score)})
        loseAlert.addAction(loseAction)
        present(loseAlert, animated: true, completion: nil)
    }
    
   
    
    func doesQualify(score : Int, placement : Int) {
        let alert = UIAlertController(title: "New Highscore!", message: "Enter your name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "\(self.name)"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            self.name = String(textField?.text ?? "Anonymous")
            if self.name == "Name here" {
                self.name = "Anonymous"
            }
            
            self.mastermind.firebaseNameUpdate(name: self.name)
            
            let scorer : ScoreboardPerson = ScoreboardPerson(name: self.name, score: score)
            
            self.scoreboardViewController.updateScoreBoard(scorer: scorer)
            
            self.pressScoreboardButton()
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
