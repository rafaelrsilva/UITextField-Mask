//
//  UITextField+Mask.swift
//  UITextField-Mask
//
//  Created by Rafael on 13/11/18.
//  Copyright © 2018 Rafael Ribeiro da Silva. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /**
     Represents a mask format
     */
    enum Mask {
        
        /**
         Represents no mask
         */
        case none
        
        /**
         Represents a integer number: **1234**
         */
        case number
        
        /**
         Represents a decimal number: **1.234,56**
         */
        case decimalNumber
        
        /**
         Represents a mask for brazilian zip code: **00000-000**
         */
        case zipCode
        
        /**
         Represents a mask for brazilian telephone: **(00) 0000-0000**
         */
        case telephone
        
        /**
         Represents a mask for brazilian cellphone: **(00) 00000-0000**
         */
        case cellphone
        
        /**
         Represents a mask for US telephone: **(000) 000-0000**
         */
        case usTelephone
        
        /**
         Represents a mask for a date: **00/00/0000**
         */
        case dayMonthYear
        
        /**
         Represents a mask for a date: **0000/00/00**
         */
        case yearMonthDay
        
        /**
         Represents a mask for a time: **00:00:00**
         */
        case hoursMinutesSeconds
        
        /**
         Represents a mask for a time without seconds: **00:00**
         */
        case hoursMinites
        
        /**
         Represents a mask for a brazilian CPF document number: **000.000.000-00**
         */
        case cpfNumber
        
        /**
         Represents a mask for a brazilian CNPJ document number: **00.000.000/0000-00**
         */
        case cnpjNumber
        
        /**
         Represents a custom mask format
         */
        case custom(format: String)
        
        public var format: String {
            switch self {
                case .none,
                     .number,
                     .decimalNumber:
                    return ""
                
                case .zipCode:
                    return "00000-000"
                
                case .telephone:
                    return "(00) 0000-0000"
                
                case .cellphone:
                    return "(00) 00000-0000"
                
                case .usTelephone:
                    return "(000) 000-0000"
                
                case .dayMonthYear:
                    return "00/00/0000"
                
                case .yearMonthDay:
                    return "0000/00/00"
                
                case .hoursMinutesSeconds:
                    return "00:00:00"
                
                case .hoursMinites:
                    return "00:00"
                
                case .cpfNumber:
                    return "000.000.000-00"
                
                case .cnpjNumber:
                    return "00.000.000/0000-00"
                
                case .custom(let format):
                    return format.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
}
