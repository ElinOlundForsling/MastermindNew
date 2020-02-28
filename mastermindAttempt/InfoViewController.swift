//
//  InfoViewController.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-05.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit
import PureLayout

class InfoViewController: UIViewController {
    
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "INFO"
        label.font = UIFont(name: "Quicksand-Regular", size: 22)
        label.textColor = .customRed
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var infoTextField: UITextView = {
        let textField = UITextView()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 13
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        textField.attributedText = NSAttributedString(string: self.info, attributes: attributes)
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
    
    
    let info : String = "Made by Elin Ölund Forsling, may she rest in peace, with Swift as a student project.  As it costs money to keep this up on Appstore, consider buying me a coffee if you have enjoyed this app? :)  For more cool projects, visit my portfolio at: "
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackground
        self.view.addSubview(infoView)
        self.infoView.addSubview(infoTextField)
        self.infoView.addSubview(infoLabel)
        self.infoView.addSubview(closeButton)
    }
    
    override func updateViewConstraints() {
        infoView.autoPinEdgesToSuperviewSafeArea()
        infoTextField.autoPinEdge(.bottom, to: .bottom, of: infoView, withOffset: -16.0)
        infoTextField.autoPinEdge(.top, to: .bottom, of: infoLabel, withOffset: 32.0)
        infoTextField.autoPinEdge(.trailing, to: .trailing, of: infoView, withOffset: -16.0)
        infoTextField.autoPinEdge(.leading, to: .leading, of: infoView, withOffset: 16.0)
        
        infoLabel.autoAlignAxis(.horizontal, toSameAxisOf: closeButton)
        infoLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        
        closeButton.autoSetDimensions(to: CGSize(width: 40.0, height: 40.0))
        closeButton.autoPinEdge(.top, to: .top, of: infoView, withOffset: 16.0)
        closeButton.autoPinEdge(.trailing, to: .trailing, of: infoView, withOffset: -16.0)
        
        super.updateViewConstraints()
    }

}
