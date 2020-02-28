//
//  logoColors.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-04.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import Foundation
import UIKit

class LogoColors {
    
    func setMastermindColors(logo : UILabel) {
        let mText = "M"
        let aText = "A"
        let sText = "S"
        let tText = "T"
        let eText = "E"
        let rText = "R"
        let attrsString =  NSMutableAttributedString(string:logo.text!);
        
        attrsString.addAttribute(NSAttributedString.Key.kern, value: 2, range: NSRange(location: 0, length: attrsString.length - 1))
                
        let mRange = (logo.text! as NSString).range(of: mText)
        if (mRange.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:UIColor.customRed,range:mRange)
        }
        let aRange = (logo.text! as NSString).range(of: aText)
        if (aRange.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:UIColor.customOrange,range:aRange)
        }
        let sRange = (logo.text! as NSString).range(of: sText)
        if (sRange.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:UIColor.customYellow,range:sRange)
        }
        let tRange = (logo.text! as NSString).range(of: tText)
        if (tRange.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:UIColor.customGreen,range:tRange)
        }
        let eRange = (logo.text! as NSString).range(of: eText)
        if (eRange.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:UIColor.customBlue,range:eRange)
        }
        let rRange = (logo.text! as NSString).range(of: rText)
        if (rRange.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:UIColor.customPurple,range:rRange)
        }
        
        logo.attributedText = attrsString
    }
    
}
