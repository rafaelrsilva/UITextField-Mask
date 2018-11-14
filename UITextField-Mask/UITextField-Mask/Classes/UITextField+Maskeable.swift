//
//  UITextField+Maskeable.swift
//  UITextField-Mask
//
//  Created by Rafael on 13/11/18.
//  Copyright © 2018 Rafael Ribeiro da Silva. All rights reserved.
//

import UIKit

private extension UITextField {
    
    subscript(key: String) -> Any? {
        get {
            return UITextField.properties[self]?[key]
        }
        set(value) {
            if UITextField.properties[self] == nil {
                UITextField.properties[self] = [:]
            }
            
            UITextField.properties[self]![key] = value
        }
    }
    
    /**
     Property that holds values for multiple UITextField instances.
     */
    static var properties: [UITextField: [String: Any]] = [:]
}

//MARK: - Properties

public extension UITextField {
    
    /**
     Getter for the mask of the text field
     */
    private var maskGetter: ((UITextField) -> Mask)? {
        get {
            return self["maskGetter"] as? (UITextField) -> Mask
        }
        set(value) {
            self["maskGetter"] = value
        }
    }
    
    /**
     Last valid text of the text field
     */
    private var lastText: String {
        get {
            return self["lastText"] as? String ?? ""
        }
        set(value) {
            self["lastText"] = value
        }
    }
    
    /**
     Unmasked text value according to the current mask format
     */
    private(set) var unmaskedText: String {
        get {
            return self["unmaskedText"] as? String ?? ""
        }
        set(value) {
            self["unmaskedText"] = value
        }
    }
}

//MARK: - Public methods

public extension UITextField {
    
    /**
     Apply a specific mask format
     
     - Parameter mask: Mask to apply
     */
    public func maskField(with mask: Mask) {
        maskGetter = { _ in mask }
        addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
    }
    
    /**
     Apply a mask format according to the returned mask from the handler
     
     - Parameter handler: Handler to get mask format
     */
    public func maskFieldDynamically(handler: @escaping (UITextField) -> Mask) {
        maskGetter = handler
        addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
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
}

//MARK: - Private methods

private extension UITextField {
    
    @objc private func valueDidChange() {
        guard let mask = maskGetter?(self) else {
            return
        }
        
        switch mask {
            case .number:
                text = applyMaskForNumber()
                unmaskedText = text!
            
            case .decimalNumber:
                text = applyMaskForDecimalNumber()
                unmaskedText = text!
                unmaskedText = unmaskedText.replacingOccurrences(of: ",", with: "")
                unmaskedText = unmaskedText.replacingOccurrences(of: ".", with: "")
            
            default:
                text = applyMask(mask)
                unmaskedText = unmaskedText(from: mask)
        }
        
        lastText = text!
    }
    
    private func applyMaskForNumber() -> String {
        guard let text = self.text else {
            return ""
        }
        
        if hasOnlyNumber(in: text) {
            return text
        }
        
        return lastText
    }
    
    private func applyMaskForDecimalNumber() -> String {
        guard var text = self.text else {
            return ""
        }
        
        text = text.replacingOccurrences(of: ",", with: "")
        text = text.replacingOccurrences(of: ".", with: "")
        
        guard hasOnlyNumber(in: text), let decimal = Decimal(string: text) else {
            return lastText
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        return formatter.string(from: NSDecimalNumber(decimal: decimal / 100))!
    }
    
    private func applyMask(_ mask: Mask) -> String {
        let maskFormat = mask.format
        var masked = ""
        let trimmed = unmaskedText(from: mask)
        
        var currentMaskIndex = maskFormat.startIndex
        var currentTrimmedIndex = trimmed.startIndex
        
        while currentMaskIndex != maskFormat.endIndex {
            if currentTrimmedIndex == trimmed.endIndex {
                break
            }
            
            switch MaskSpecialChars(rawValue: maskFormat[currentMaskIndex]) {
                case .none:
                    masked = "\(masked)\(maskFormat[currentMaskIndex])"
                
                case .some(let option):
                    if hasSpecialCharacters(in: trimmed) {
                        return lastText
                    }
                    
                    let isNumber = UInt(trimmed) != nil
                    
                    if option == .numbers && !isNumber || option == .letters && isNumber {
                        return lastText
                    }
                    
                    masked = "\(masked)\(trimmed[currentTrimmedIndex])"
                    currentTrimmedIndex = trimmed.index(after: currentTrimmedIndex)
                }
            
            currentMaskIndex = maskFormat.index(after: currentMaskIndex)
        }
        
        return masked
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
