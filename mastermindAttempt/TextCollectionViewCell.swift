//
//  GuessTextCollectionViewCell.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-05.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    
    lazy var guessLabel : UILabel = {
        let label = UILabel()
        label.text = "GUESS"
        label.font = UIFont(name: "Quicksand", size: 14)
        label.textColor = .customBlack
        return label
    }()
    
    var guessButtonAction : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(guessLabel)
        guessLabel.autoCenterInSuperview()
        self.isUserInteractionEnabled = true
        
        let screenSize : CGRect = UIScreen.main.bounds
        if screenSize.height < 896 {
            self.contentView.autoSetDimensions(to: CGSize(width: 40, height: 32))
        } else {
            self.contentView.autoSetDimensions(to: CGSize(width: 40, height: 40))
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(textClicked))
        self.addGestureRecognizer(tap)
    }
    
    @objc func textClicked() {
        guessButtonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
