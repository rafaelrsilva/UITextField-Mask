//
//  UITextField+Maskeable.swift
//  UITextField-Mask
//
//  Created by Rafael on 13/11/18.
//  Copyright © 2018 Rafael Ribeiro da Silva. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /**
     Property that holds mask string for multiple UITextField instances.
     */
    private static var masks: [UITextField: (UITextField) -> Mask] = [:]
    
    /**
     Property that holds last valid text for multiple UITextField instances.
     */
    private static var last: [UITextField: String] = [:]
    
    /**
     Getter for the mask of the current text field
     */
    private var maskGetter: ((UITextField) -> Mask)? {
        get {
            return UITextField.masks[self]
        }
        set(value) {
            UITextField.masks[self] = value
        }
    }
    
    /**
     Last valid text of the text field
     */
    private var lastText: String? {
        get {
            return UITextField.last[self]
        }
        set(value) {
            UITextField.last[self] = value
        }
    }
    
    /**
     Apply a specific mask format
     
     - Parameter mask: Mask to apply
     */
    public func maskField(with mask: Mask) {
        maskGetter = { _ in mask }
        addTarget(self, action: #selector(valueDidChangeAgain), for: .editingChanged)
    }
    
    /**
     Apply a mask format according to the returned mask from the handler
     
     - Parameter handler: Handler to get mask format
     */
    public func maskFieldDynamically(handler: @escaping (UITextField) -> Mask) {
        maskGetter = handler
        addTarget(self, action: #selector(valueDidChangeAgain), for: .editingChanged)
    }
    
    /**
     Returns the unmasked text value according to the current mask format
     
     - Returns: The unmasked text value
     */
    public func unmaskedText() -> String {
        if let mask = maskGetter?(self) {
            return unmaskedText(from: mask)
        }
        
        return unmaskedText(from: .none)
    }
    
    /**
     Returns the unmasked text value according to a specific mask format
     
     - Parameter mask: Mask to be used to unmask text value
     - Returns: The unmasked text value
     */
    public func unmaskedText(from mask: Mask) -> String {
        var text = self.text ?? ""
        var format = mask.format
        
        MaskSpecialChars.rawValues.forEach { (value) in
            format = format.replacingOccurrences(of: "\(value)", with: "")
        }
        
        var currentIndex = format.startIndex
        let lastIndex = format.endIndex
        
        while currentIndex != lastIndex {
            text = text.replacingOccurrences(of: "\(format[currentIndex])", with: "")
            currentIndex = format.index(after: currentIndex)
        }
        
        return text
    }
    
    @objc private func valueDidChangeAgain() {
        guard let text = self.text, !text.isEmpty else {
            lastText = ""
            return
        }
        
        guard let mask = maskGetter?(self) else {
            return
        }
        
        switch mask {
            case .number:
                if !hasOnlyNumber(in: text) {
                    self.text = lastText
                }
                
                lastText = self.text
                return
            
            case .decimalNumber:
                var number = text.replacingOccurrences(of: ",", with: "")
                number = number.replacingOccurrences(of: ".", with: "")
                
                if !hasOnlyNumber(in: number) {
                    self.text = lastText
                }
                else {
                    let decimal: Decimal = Decimal(string: number)! / 100
                    
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.groupingSeparator = "."
                    formatter.decimalSeparator = ","
                    
                    self.text = formatter.string(from: NSDecimalNumber(decimal: decimal))
                }
                
                lastText = self.text
                return
            
            default: break
        }
        
        let maskFormat = mask.format
        
        var maskedText = ""
        let trimmed = unmaskedText(from: mask)
        
        var currentMaskIndex = maskFormat.startIndex
        var currentTrimmedIndex = trimmed.startIndex
        
        maskIndexLoop: while currentMaskIndex != maskFormat.endIndex {
            
            if currentTrimmedIndex == trimmed.endIndex {
                break maskIndexLoop
            }
            
            switch MaskSpecialChars(rawValue: maskFormat[currentMaskIndex]) {
                case .none:
                    maskedText = "\(maskedText)\(maskFormat[currentMaskIndex])"
                
                case .some(let someOption):
                    if hasSpecialCharacters(in: "\(trimmed)") {
                        maskedText = lastText ?? ""
                        break maskIndexLoop
                    }
                    
                    let isNumber = UInt("\(trimmed)") != nil
                    
                    switch someOption {
                        case .numbers:
                            if !isNumber {
                                maskedText = lastText ?? ""
                                break maskIndexLoop
                            }
                        
                        case .numbersAndLetters:
                            break
                        
                        case .letters:
                            if isNumber {
                                maskedText = lastText ?? ""
                                break maskIndexLoop
                            }
                    }
                    
                    maskedText = "\(maskedText)\(trimmed[currentTrimmedIndex])"
                    currentTrimmedIndex = trimmed.index(after: currentTrimmedIndex)
            }
            
            currentMaskIndex = maskFormat.index(after: currentMaskIndex)
        }
        
        self.text = maskedText
        lastText = self.text
    }
    
    private func hasSpecialCharacters(in string: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options()) {
            return regex.firstMatch(in: string, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: string.count - 1)) != nil
        }
        
        return false
    }
    
    private func hasOnlyNumber(in string: String) -> Bool {
        return string.trimmingCharacters(in: .decimalDigits).isEmpty
    }
}
