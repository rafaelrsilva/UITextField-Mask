//
//  MaskBaseTest.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest

#if canImport(UITextFieldMask)

@testable import UITextFieldMask

#else

@testable import UITextField_Mask

#endif

class MaskBaseTest: XCTestCase {

    /**
     The system under test.
     */
    private(set) var field: UITextField!
    
    override func setUp() {
        field = UITextField()
    }
    
    override func tearDown() {}
}
