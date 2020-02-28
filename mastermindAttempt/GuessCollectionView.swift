//
//  Guess.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-04.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit


class GuessCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // MARK: OVERRIDE INIT
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionViewLayout = GuessCollectionViewLayout().generateLayout()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .clear
        self.register(GuessCollectionViewCell.self, forCellWithReuseIdentifier: guessID)
        self.register(DotsCollectionViewCell.self, forCellWithReuseIdentifier: dotID)
        self.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: emptyID)
        self.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: textID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: NUMBER OF SECTIONS/ITEMS
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // MARK: ID'S
    
    let guessID = "GuessID"
    let dotID = "DotID"
    let emptyID = "EmptyID"
    let textID = "TextID"
    
    
    // MARK: COLLECTIONVIEW CELL VARIABLES
    
    let dotIndexArray = [59, 53, 47, 41, 35, 29, 23, 17, 11, 5]
    let emptyIndexArray = [4, 10, 16, 22, 28, 34, 40, 46, 52, 58]
    let guessIndexArray: [[Int]] = [[54, 55, 56, 57], [48, 49, 50, 51], [42, 43, 44, 45], [36, 37, 38, 39], [30, 31, 32, 33], [24, 25, 26, 27], [18, 19, 20, 21], [12, 13, 14, 15], [6, 7, 8, 9], [0, 1, 2, 3]]
    
    
    var updateCell = false
    
    var buttonEventAction : (() -> ())?
    var hideCell : (() -> ())?
    
    var black = 0
    var white = 0
    
    
    // MARK: UPDATE COLLECTIONVIEW CELLS
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let guessCell = collectionView.dequeueReusableCell(withReuseIdentifier: guessID, for: indexPath) as! GuessCollectionViewCell
        let dotCell = collectionView.dequeueReusableCell(withReuseIdentifier: dotID, for: indexPath) as! DotsCollectionViewCell
        let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyID, for: indexPath) as! EmptyCollectionViewCell
        let textCell = collectionView.dequeueReusableCell(withReuseIdentifier: textID, for: indexPath) as! TextCollectionViewCell
        
        textCell.guessButtonAction = { [unowned self] in
            self.buttonEventAction?()
        }
        
        guessCell.hideCell = { [unowned self] in
            self.hideCell?()
        }
        
        let dots = [dotCell.dot1, dotCell.dot2, dotCell.dot3, dotCell.dot4]
        
        for i in 0...3 {
            if black > 0 {
                dots[i].backgroundColor = .customBlack
                dots[i].layer.borderWidth = 0
                black -= 1
            } else if white > 0 {
                dots[i].backgroundColor = .customWhite
                dots[i].layer.borderWidth = 1
                white -= 1
            } else {
                dots[i].backgroundColor = .customGrey
                dots[i].layer.borderWidth = 0
            }
        }
        
        if updateCell {
            for index in 0..<dotIndexArray.count {
                if indexPath.item == dotIndexArray[index] {
                    return dotCell
                }
            }
        }

        
        for i in 0...9 {
            for j in 0...3 {
                if indexPath.item == self.guessIndexArray[i][j] {
                    guessCell.contentView.backgroundColor = .clear
                    guessCell.tag = 0
                    if GameplayView.screenSize.height < GameplayView.tallheight {
                        guessCell.contentView.layer.borderWidth = 1.5
                    } else {
                        guessCell.contentView.layer.borderWidth = 2
                    }
                    return guessCell
                }
            }
        }
        for index in 0..<dotIndexArray.count {
            if indexPath.item == dotIndexArray[index] {
                textCell.isHidden = true
                return textCell
            }
        }
        
        for index in 0..<emptyIndexArray.count {
            if indexPath.item == emptyIndexArray[index] {
                return emptyCell
            }
        }
        return guessCell
    }

}
