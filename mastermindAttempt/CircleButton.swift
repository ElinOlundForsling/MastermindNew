//
//  CircleButton.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-03.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout

class CircleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 160/225, green: 160/225, blue: 160/225, alpha: 1).cgColor
        self.isUserInteractionEnabled = true
        self.layer.masksToBounds = true
        if GameplayView.screenSize.height < GameplayView.tallheight {
            self.layer.cornerRadius = 16
            
        } else {
            self.layer.cornerRadius = 20
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    color.setFill()
    UIRectFill(rect)
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    setBackgroundImage(colorImage, for: state)
  }
}
