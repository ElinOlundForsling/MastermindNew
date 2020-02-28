//
//  ProfileView.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-01-24.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout


// MARK: PROTOCOL

protocol GameplayViewDelegate: class {
    func sendGuess(userGuess : [Int])
    func pressRulesButton()
    func pressInfoButton()
    func pressScoreboardButton()
    func sendBoard(guessBoard : [Int], currentGuess: [Int])
}

class GameplayView: UIView {
    
    
    // MARK: VARIABLES
    
    static let screenSize : CGRect = UIScreen.main.bounds
    static let tallheight : CGFloat = 896.0
    
    weak var delegate: GameplayViewDelegate?
    var activeRow = 9
    var userGuess : [Int] = Array(repeating: 0, count: 4)
    var guessBoard = Array(repeating: 0, count: 40)
    
    
    // MARK: VIEW ELEMENTS
    
    lazy var mastermindLogo: UILabel = {
        let label = UILabel()
        label.text = "MASTERMIND"
        label.font = UIFont(name: "Quicksand", size: 26)
        label.textColor = .customBlack
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        var label = UILabel()
        label.text = "SCORE"
        label.font = UIFont(name: "Quicksand", size: 14)
        label.textColor = .customCharcoal
        return label
    }()
    
    lazy var streakLabel: UILabel = {
        var label = UILabel()
        label.text = "STREAK"
        label.font = UIFont(name: "Quicksand", size: 14)
        label.textColor = .customCharcoal
        return label
    }()
    
    lazy var scoreNumberLabel: UILabel = {
        var label = UILabel()
        label.text = "00"
        label.font = UIFont(name: "Quicksand-Bold", size: 14)
        label.textColor = .customCharcoal
        label.textAlignment = .right
        return label
    }()
    
    lazy var streakNumberLabel: UILabel = {
        var label = UILabel()
        label.text = "00"
        label.font = UIFont(name: "Quicksand-Bold", size: 14)
        label.textColor = .customCharcoal
        label.textAlignment = .right
        return label
    }()
    
    lazy var rulesButton: UIButton = {
        let button = UIButton()
        button.setTitle("RULES", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 16)
        button.setTitleColor(.customCharcoal, for: .normal)
        button.layer.cornerRadius = 0
        button.layer.borderColor = UIColor.customCharcoal.cgColor
        button.layer.borderWidth = 0
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clickRulesButton), for: .touchDown)
        return button
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("INFO", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 16)
        button.setTitleColor(.customCharcoal, for: .normal)
        button.layer.cornerRadius = 0
        button.layer.borderColor = UIColor.customCharcoal.cgColor
        button.layer.borderWidth = 0
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clickInfoButton), for: .touchDown)
        return button
    }()
    
    lazy var scoreboardButton: UIButton = {
        let button = UIButton()
        button.setTitle("SCOREBOARD", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 16)
        button.setTitleColor(.customCharcoal, for: .normal)
        button.layer.cornerRadius = 0
        button.layer.borderColor = UIColor.customCharcoal.cgColor
        button.layer.borderWidth = 0
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clickScoreboardButton), for: .touchDown)
        return button
    }()
    
    lazy var space1: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "buttonSpacing1"
        return guide
    }()
    
    lazy var space2: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "buttonSpacing2"
        return guide
    }()
    
    
    // MARK: CollectionView
    
    lazy var collectionView: GuessCollectionView = {
        let cv = GuessCollectionView()
        return cv
    }()
    
    lazy var redCircle: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .customRed
        button.setBackgroundColor(.customRedHighlight, for: .highlighted)
        button.layer.borderWidth = 0
        button.tag = 1
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return button
    }()
    
    lazy var orangeCircle: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .customOrange
        button.setBackgroundColor(.customOrangeHighlight, for: .highlighted)
        button.layer.borderWidth = 0
        button.tag = 2
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return button
    }()
    
    lazy var yellowCircle: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .customYellow
        button.setBackgroundColor(.customYellowHighlight, for: .highlighted)
        button.layer.borderWidth = 0
        button.tag = 3
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return button
    }()
    
    lazy var greenCircle: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .customGreen
        button.setBackgroundColor(.customGreenHighlight, for: .highlighted)
        button.layer.borderWidth = 0
        button.tag = 4
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return button
    }()
    
    lazy var blueCircle: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .customBlue
        button.setBackgroundColor(.customBlueHighlight, for: .highlighted)
        button.layer.borderWidth = 0
        button.tag = 5
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return button
    }()
    
    lazy var purpleCircle: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .customPurple
        button.setBackgroundColor(.customPurpleHighlight, for: .highlighted)
        button.layer.borderWidth = 0
        button.tag = 6
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return button
    }()
    
    
    // MARK: Add Subviews
    
    func addSubviews() {
        addSubview(mastermindLogo)
        addSubview(scoreLabel)
        addSubview(streakLabel)
        addSubview(scoreNumberLabel)
        addSubview(streakNumberLabel)
        addSubview(rulesButton)
        addSubview(infoButton)
        addSubview(scoreboardButton)
        addLayoutGuide(space1)
        addLayoutGuide(space2)
        addSubview(collectionView)
        addSubview(redCircle)
        addSubview(orangeCircle)
        addSubview(yellowCircle)
        addSubview(greenCircle)
        addSubview(blueCircle)
        addSubview(purpleCircle)
    }
    

    // MARK: INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .customBackground
        addSubviews()
        LogoColors().self.setMastermindColors(logo: mastermindLogo)
        
        
        // MARK: RECIEVE BUTTON CLICK AND DELEGATE
        
        collectionView.buttonEventAction = { [unowned self] in
            self.delegate?.sendGuess(userGuess : self.userGuess)
        }
        
        collectionView.hideCell = { [unowned self] in
            self.hideCell()
        }
    }
    
    
    // MARK: UPDATE CONSTRAINS
    
    override func updateConstraints() {
        
        mastermindLogo.autoPinEdge(toSuperviewEdge: .left, withInset: 32.0)
        mastermindLogo.autoPinEdge(toSuperviewEdge: .top, withInset: 64.0)
        
        scoreLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 64.0)
        scoreNumberLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 64.0)
        
        streakLabel.autoPinEdge(.top, to: .bottom, of: scoreLabel, withOffset: 5)
        streakNumberLabel.autoPinEdge(.top, to: .bottom, of: scoreNumberLabel, withOffset: 5)
        
        scoreNumberLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32.0)
        streakNumberLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32.0)
        
        scoreLabel.autoPinEdge(.right, to: .left, of: scoreNumberLabel, withOffset: -15)
        streakLabel.autoAlignAxis(.vertical, toSameAxisOf: scoreLabel)
        
        rulesButton.autoSetDimension(.height, toSize: 36.0)
        infoButton.autoSetDimension(.height, toSize: 36.0)
        scoreboardButton.autoSetDimension(.height, toSize: 36.0)
        
        rulesButton.autoSetDimension(.width, toSize: 60.0)
        infoButton.autoSetDimension(.width, toSize: 60.0)
        scoreboardButton.autoSetDimension(.width, toSize: 120.0)
        rulesButton.autoPinEdge(.top, to: .bottom, of: mastermindLogo, withOffset: 18)
        rulesButton.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        scoreboardButton.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        
        space1.widthAnchor.constraint(equalTo: space2.widthAnchor).isActive = true
        
        infoButton.centerYAnchor.constraint(equalTo: rulesButton.centerYAnchor).isActive = true
        scoreboardButton.centerYAnchor.constraint(equalTo: rulesButton.centerYAnchor).isActive = true
        rulesButton.trailingAnchor.constraint(equalTo: space1.leadingAnchor).isActive = true
        infoButton.leadingAnchor.constraint(equalTo: space1.trailingAnchor).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: space2.leadingAnchor).isActive = true
        scoreboardButton.leadingAnchor.constraint(equalTo: space2.trailingAnchor).isActive = true
        
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 48.0)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 48.0)
        collectionView.autoPinEdge(.top, to: .bottom, of: infoButton, withOffset: 16.0)
        collectionView.autoPinEdge(.bottom, to: .top, of: redCircle, withOffset: -16.0)
        
        
        let colorRow: NSArray = [redCircle, orangeCircle, yellowCircle, greenCircle, blueCircle, purpleCircle]
        
        if GameplayView.screenSize.height < GameplayView.tallheight {
            NSLayoutConstraint.autoSetIdentifier("GamePlayView Small", forConstraints: {
                colorRow.autoSetViewsDimension(.height, toSize: 32.0)
                colorRow.autoSetViewsDimension(.width, toSize: 32.0)
                colorRow.autoDistributeViews(along: .horizontal, alignedTo: .horizontal, withFixedSize: 32.0, insetSpacing: true)
            })
        } else {
            NSLayoutConstraint.autoSetIdentifier("GamePlayView Big", forConstraints: {
                colorRow.autoSetViewsDimension(.height, toSize: 40.0)
                colorRow.autoSetViewsDimension(.width, toSize: 40.0)
                colorRow.autoDistributeViews(along: .horizontal, alignedTo: .horizontal, withFixedSize: 40.0, insetSpacing: true)
            })
            
        }
        
        redCircle.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32.0)
        super.updateConstraints() // Always at the bottom of the function
    }
    
    
    // MARK: CLICK COLOR BUTTON
    
    @objc func buttonClicked(sender:UIButton) {
        for i in 0...3 {
            let indexCell = collectionView.cellForItem(at: IndexPath(item: i, section: activeRow))
            if indexCell?.tag == 0 {
                
                indexCell?.contentView.layer.borderWidth = 0
                indexCell?.tag = sender.tag
                
                
                switch sender.tag {
                case 1:
                    indexCell?.contentView.backgroundColor = .customRed
                    userGuess[i] = 1
                case 2:
                    indexCell?.contentView.backgroundColor = .customOrange
                    userGuess[i] = 2
                case 3:
                    indexCell?.contentView.backgroundColor = .customYellow
                    userGuess[i] = 3
                case 4:
                    indexCell?.contentView.backgroundColor = .customGreen
                    userGuess[i] = 4
                case 5:
                    indexCell?.contentView.backgroundColor = .customBlue
                    userGuess[i] = 5
                case 6:
                    indexCell?.contentView.backgroundColor = .customPurple
                    userGuess[i] = 6
                default:
                    indexCell?.contentView.backgroundColor = .clear
                    userGuess[i] = 0
                }
                let currentIndex = i + (activeRow * 4)
                guessBoard[currentIndex] = Int(sender.tag)
                self.delegate?.sendBoard(guessBoard: guessBoard, currentGuess: userGuess)
                checkIfFull()
                break
            }
        }
    }
    
    
    // MARK: CHECK IF FULL
    
    func checkIfFull() {
        for i in 0...3 {
            let indexCell = collectionView.cellForItem(at: IndexPath(item: i, section: activeRow))
            if indexCell?.contentView.backgroundColor == .clear {
                return
            }
        }
        collectionView.cellForItem(at: IndexPath(item: 5, section: activeRow))!.isHidden = false
    }
    
    
    // MARK: HIDE GUESS BUTTON
    
    func hideCell() {
        collectionView.cellForItem(at: IndexPath(item: 5, section: activeRow))!.isHidden = true
    }
    
    
    // MARK: UPDATE DOTS
    
    func updateDots(white : Int, black : Int) {
        self.collectionView.white = white
        self.collectionView.black = black
        self.collectionView.updateCell = true
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: [IndexPath (item: 5, section: self.activeRow)])
        }, completion: nil)
        self.collectionView.cellForItem(at: IndexPath(item: 5, section: self.activeRow))?.isHidden = false
    }
    
    
    //MARK: UPDATE LABELS
    
    func updateLabels(streak : Int, score : Int) {
        if streak < 10 {
            streakNumberLabel.text = "0" + String(streak)
        } else {
            streakNumberLabel.text = String(streak)
        }
        
        if score < 10 {
            scoreNumberLabel.text = "0" + String(score)
        } else {
            scoreNumberLabel.text = String(score)
        }
    }
    
    
    // MARK: UPDATE BOARD FROM FIREBASE
    
    func updateBoard(guessboard : [Int], userGuess: [Int], dotboard : [Int]) {
        self.userGuess = userGuess
        
        for i in activeRow...9 {
            let correspondingFirstPos = i * 4
            let correspondingGuessPos : [Int] = [correspondingFirstPos, correspondingFirstPos + 1, correspondingFirstPos + 2, correspondingFirstPos + 3]
            
            for j in 0...3 {
                let indexCell = collectionView.cellForItem(at: IndexPath(item: j, section: i))
                
                switch guessboard[correspondingGuessPos[j]] {
                case 0:
                    indexCell?.contentView.backgroundColor = .clear
                    indexCell?.tag = 0
                case 1:
                    indexCell?.contentView.backgroundColor = .customRed
                    indexCell?.contentView.layer.borderWidth = 0
                    indexCell?.tag = 1
                case 2:
                    indexCell?.contentView.backgroundColor = .customOrange
                    indexCell?.contentView.layer.borderWidth = 0
                    indexCell?.tag = 2
                case 3:
                    indexCell?.contentView.backgroundColor = .customYellow
                    indexCell?.contentView.layer.borderWidth = 0
                    indexCell?.tag = 3
                case 4:
                    indexCell?.contentView.backgroundColor = .customGreen
                    indexCell?.contentView.layer.borderWidth = 0
                    indexCell?.tag = 4
                case 5:
                    indexCell?.contentView.backgroundColor = .customBlue
                    indexCell?.contentView.layer.borderWidth = 0
                    indexCell?.tag = 5
                case 6:
                    indexCell?.contentView.backgroundColor = .customPurple
                    indexCell?.contentView.layer.borderWidth = 0
                    indexCell?.tag = 6
                default:
                    indexCell?.contentView.backgroundColor = .clear
                    indexCell?.tag = 0
                }
            }
        }
        
        
        if activeRow < 9 {
            for i in activeRow + 1...9 {
                collectionView.cellForItem(at: IndexPath(item: 5, section: i))!.isHidden = false
                self.collectionView.updateCell = true
                let correspondingFirstPos = i * 4
                let correspondingGuessPos : [Int] = [correspondingFirstPos, correspondingFirstPos + 1, correspondingFirstPos + 2, correspondingFirstPos + 3]
                
                var black = 0
                var white = 0
                for j in 0...3 {
                    if dotboard[correspondingGuessPos[j]] == 1 {
                        black += 1
                    } else if dotboard[correspondingGuessPos[j]] == 2 {
                        white += 1
                    }
                }
                collectionView.black = black
                collectionView.white = white
                
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadItems(at: [IndexPath (item: 5, section: i)])
                }, completion: nil)
            }
        }
        self.collectionView.updateCell = false
    }
    
    
    // MARK: RESET BOARD
    
    func resetBoard(streak : Int, score : Int) {
        activeRow = 9
        collectionView.black = 0
        collectionView.white = 0
        collectionView.updateCell = false
        guessBoard = Array(repeating: 0, count: 40)
        for i in 0...9 {
            collectionView.reloadSections([i])
        }
        collectionView.layoutIfNeeded()
        updateLabels(streak: streak, score: score)
    }
    
    
    // MARK: PRESS RULES/INFO BUTTONS
    
    @objc func clickRulesButton() {
        delegate?.pressRulesButton()
    }
    
    @objc func clickInfoButton() {
        delegate?.pressInfoButton()
    }
    
    @objc func clickScoreboardButton() {
        delegate?.pressScoreboardButton()
    }
    
    
    // MARK: REQUIRED INIT
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
