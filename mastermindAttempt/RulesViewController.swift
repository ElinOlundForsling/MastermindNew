//
//  RulesViewController.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-05.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout

class RulesViewController: UIViewController {
    
    
    lazy var rulesView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var rulesLabel: UILabel = {
        let label = UILabel()
        label.text = "RULES"
        label.font = UIFont(name: "Quicksand-Regular", size: 22)
        label.textColor = .customRed
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var rulesTextField: UITextView = {
        let textField = UITextView()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 13
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        textField.attributedText = NSAttributedString(string: self.rules, attributes: attributes)
        textField.font = UIFont(name: "Quicksand-Regular", size: 16)
        textField.textColor = .customCharcoal
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = true
        textField.isEditable = false
        textField.isScrollEnabled = true
        return textField
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(systemName: "multiply")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .customRed
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(close), for: .touchDown)
        return button
    }()
    
    @objc func close(sender: UIButton) {
        let transition: CATransition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: true)
    }
    
    
    let rules : String = "To win Mastermind, you'll have to correctly guess what colors are used, and in what order.  You start by pressing the colors on the bottom row, and once you're done, press the GUESS button. You'll then see four dots in a square formation pop up. A black dot means that you have at least one color in the right spot, a white dot means you have the right color, but in the wrong spot, and a grey dot means that it's neither the right spot or color. The order the dots are displayed in does not correspond to the colors; black dots always go first, followed by white and grey.  For example, you might see one black dot, two whites and one grey. That means one of your colors is exactly where it should be, two of your colors are the right color but the wrong space, and one color is completely wrong. A solution can contain several of the same color.  This version of Mastermind is played in ten rounds, all with different solutions. The faster you figure out the solution in each round, the more points you get. If you get to the last line without correctly guessing the solution, that round is lost and you move on to the next one."
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackground
        self.view.addSubview(rulesView)
        self.rulesView.addSubview(rulesTextField)
        self.rulesView.addSubview(rulesLabel)
        self.rulesView.addSubview(closeButton)
    }
    
    override func updateViewConstraints() {
        rulesView.autoPinEdgesToSuperviewSafeArea()
        rulesTextField.autoPinEdge(.bottom, to: .bottom, of: rulesView, withOffset: -16.0)
        rulesTextField.autoPinEdge(.top, to: .bottom, of: rulesLabel, withOffset: 32.0)
        rulesTextField.autoPinEdge(.trailing, to: .trailing, of: rulesView, withOffset: -16.0)
        rulesTextField.autoPinEdge(.leading, to: .leading, of: rulesView, withOffset: 16.0)
        
        rulesLabel.autoAlignAxis(.horizontal, toSameAxisOf: closeButton)
        rulesLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        closeButton.autoSetDimensions(to: CGSize(width: 40.0, height: 40.0))
        closeButton.autoPinEdge(.top, to: .top, of: rulesView, withOffset: 16.0)
        closeButton.autoPinEdge(.trailing, to: .trailing, of: rulesView, withOffset: -16.0)
        
        super.updateViewConstraints()
    }
}
