//
//  UITextField+MaskSpecialChars.swift
//  UITextField-Mask
//
//  Created by Rafael on 13/11/18.
//  Copyright © 2018 Rafael Ribeiro da Silva. All rights reserved.
//

import UIKit

extension UITextField {
    
    /**
     Special characters used to create a mask format
     */
    enum MaskSpecialChars: Character {
        
        /**
         Accept only numbers
         */
        case numbers = "0"
        
        /**
         Accept whether number or letters
         */
        case numbersAndLetters = "A"
        
        /**
         Accept only letters
         */
        case letters = "S"
        
        /**
         Array with all rawValues
         */
        static var rawValues: [Character] {
            return [
                MaskSpecialChars.numbers.rawValue,
                MaskSpecialChars.numbersAndLetters.rawValue,
                MaskSpecialChars.letters.rawValue
            ]
        }
    }
}
