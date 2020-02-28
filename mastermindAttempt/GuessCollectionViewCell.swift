//
//  CollectionViewCell.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-01-31.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout

class GuessCollectionViewCell: UICollectionViewCell {
 
    var hideCell : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        self.contentView.layer.borderColor = UIColor.customGrey.cgColor
        self.tag = 0
        self.contentView.isUserInteractionEnabled = true
        
        let screenSize : CGRect = UIScreen.main.bounds
        if screenSize.height < 896 {
            self.contentView.autoSetDimensions(to: CGSize(width: 32, height: 32))
            self.contentView.layer.cornerRadius = 16
            self.contentView.layer.borderWidth = 1.5
        } else {
            self.contentView.autoSetDimensions(to: CGSize(width: 40, height: 40))
            self.contentView.layer.cornerRadius = 20
            self.contentView.layer.borderWidth = 2
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellClicked))
        self.addGestureRecognizer(tap)
    }
    
    @objc func cellClicked(sender: UITapGestureRecognizer) {
        self.contentView.backgroundColor = .clear
        self.contentView.layer.borderWidth = 2
        self.tag = 0
        hideCell?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
