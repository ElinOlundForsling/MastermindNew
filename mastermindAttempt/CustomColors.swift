//
//  CustomColors.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-02-04.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit

extension UIColor {

    class var customBackground: UIColor {
        let color = 0xF7F4F2
        return UIColor.rgb(fromHex: color)
    }
    
    class var customRed: UIColor {
        let color = 0xFF7171
        return UIColor.rgb(fromHex: color)
    }
    
    class var customRedHighlight: UIColor {
        let color = 0xffbbbb
        return UIColor.rgb(fromHex: color)
    }
    
    class var customOrange: UIColor {
        let color = 0xFFB871
        return UIColor.rgb(fromHex: color)
    }
    
    class var customOrangeHighlight: UIColor {
        let color = 0xffd8ac
        return UIColor.rgb(fromHex: color)
    }
    
    class var customYellow: UIColor {
        let color = 0xFFD971
        return UIColor.rgb(fromHex: color)
    }
    
    class var customYellowHighlight: UIColor {
        let color = 0xffeebd
        return UIColor.rgb(fromHex: color)
    }
    
    class var customGreen: UIColor {
        let color = 0x97E094
        return UIColor.rgb(fromHex: color)
    }
    
    class var customGreenHighlight: UIColor {
        let color = 0xc8f0c6
        return UIColor.rgb(fromHex: color)
    }
    
    class var customBlue: UIColor {
        let color = 0x96CEDE
        return UIColor.rgb(fromHex: color)
    }
    
    class var customBlueHighlight: UIColor {
        let color = 0xbfe5ef
        return UIColor.rgb(fromHex: color)
    }
    
    class var customPurple: UIColor {
        let color = 0xCAA4DB
        return UIColor.rgb(fromHex: color)
    }
    
    class var customPurpleHighlight: UIColor {
        let color = 0xe3ceec
        return UIColor.rgb(fromHex: color)
    }
    
    class var customWhite: UIColor {
        let color = 0xFDFDFD
        return UIColor.rgb(fromHex: color)
    }
    
    class var customAsh: UIColor {
        let color = 0xDDDDDD
        return UIColor.rgb(fromHex: color)
    }
    
    class var customGrey: UIColor {
        let color = 0xA5A5A5
        return UIColor.rgb(fromHex: color)
    }
    
    class var customCharcoal : UIColor {
        let color = 0x707070
        return UIColor.rgb(fromHex: color)
    }
    
    class var customBlack: UIColor {
        let color = 0x555555
        return UIColor.rgb(fromHex: color)
    }
    
    class func rgb(fromHex: Int) -> UIColor {

        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
