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
            return
        }
        
        guard let mask = maskGetter?(self) else {
            return
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
                        break maskIndexLoop
                    }
                    
                    let isNumber = UInt("\(trimmed)") != nil
                    
                    switch someOption {
                        case .numbers:
                            if !isNumber {
                                break maskIndexLoop
                            }
                        
                        case .numbersAndLetters:
                            break
                        
                        case .letters:
                            if isNumber {
                                break maskIndexLoop
                            }
                    }
                    
                    maskedText = "\(maskedText)\(trimmed[currentTrimmedIndex])"
                    currentTrimmedIndex = trimmed.index(after: currentTrimmedIndex)
            }
            
            currentMaskIndex = maskFormat.index(after: currentMaskIndex)
        }
        
        self.text = maskedText
    }
    
    private func hasSpecialCharacters(in string: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options()) {
            return regex.firstMatch(in: string, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: string.count - 1)) != nil
        }
        
        return false
    }
}
