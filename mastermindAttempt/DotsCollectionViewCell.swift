//
//  DotViewCollectionViewCell.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-04.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout

class DotsCollectionViewCell: UICollectionViewCell {
    
    let dot1 = Dot()
    let dot2 = Dot()
    let dot3 = Dot()
    let dot4 = Dot()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(dot1)
        self.contentView.addSubview(dot2)
        self.contentView.addSubview(dot3)
        self.contentView.addSubview(dot4)
        dot1.autoPinEdge(toSuperviewEdge: .top)
        dot1.autoPinEdge(toSuperviewEdge: .left)
        dot2.autoPinEdge(toSuperviewEdge: .top)
        dot2.autoPinEdge(toSuperviewEdge: .right)
        dot3.autoPinEdge(toSuperviewEdge: .bottom)
        dot3.autoPinEdge(toSuperviewEdge: .left)
        dot4.autoPinEdge(toSuperviewEdge: .bottom)
        dot4.autoPinEdge(toSuperviewEdge: .right)
        let screenSize : CGRect = UIScreen.main.bounds
        if screenSize.height < 896 {
            self.contentView.autoSetDimensions(to: CGSize(width: 30, height: 30))
        } else {
            self.contentView.autoSetDimensions(to: CGSize(width: 40, height: 40))
        }
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Dot: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .customGrey
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.customAsh.cgColor
        let screenSize : CGRect = UIScreen.main.bounds
        if screenSize.height < 896 {
            self.autoSetDimensions(to: CGSize(width: 8, height: 8))
            self.layer.cornerRadius = 4
        } else {
            self.autoSetDimensions(to: CGSize(width: 10, height: 10))
            self.layer.cornerRadius = 5
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
