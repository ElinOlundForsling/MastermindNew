//
//  EmptyCollectionViewCell.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-05.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.autoSetDimension(.height, toSize: 40)
        self.contentView.autoSetDimension(.width, toSize: 0)
        self.contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
