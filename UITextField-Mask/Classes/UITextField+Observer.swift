//
//  UITextField+Observer.swift
//  UITextField-Mask
//
//  Created by Rafael on 17/12/18.
//  Copyright © 2018 Rafael Ribeiro da Silva. All rights reserved.
//

import Foundation

extension UITextField {
    
    /**
     A simple class that uses `NSKeyValueObserving` to observer object value changes
     */
    final class Observer: NSObject {
        
        /**
         Boolean value indicating whether or not to execute handler
         */
        private var observing = true
        
        /**
         Handler to execute when observed object value changes
         */
        private var changeHandler: (() -> Void)?
        
        /**
         Creates an instance of observer passing a handler to execute when observed object value changes
         
         - Parameter handler: Handler to execute when observed object value changes
         */
        init(_ handler: @escaping () -> Void) {
            changeHandler = handler
        }
        
        /**
         Start value observing
         */
        func startObserving() {
            observing = true
        }
        
        /**
         Stop value observing
         */
        func stopObserving() {
            observing = false
        }
        
        //MARK: - NSKeyValueObserving
        
        public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if observing {
                changeHandler?()
            }
        }
    }
}
