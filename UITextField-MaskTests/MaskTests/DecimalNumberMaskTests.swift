//
//  DecimalNumberMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class DecimalNumberMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .decimalNumber)
    }
    
    func testUsingValidInput() {
        field.text = "1234567890"
        XCTAssertEqual(field.text, "12.345.678,90", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "1234567890", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "12.345.678,90"
        XCTAssertEqual(field.text, "12.345.678,90", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "1234567890", "Field value unmasked incorrectly")
    }
}
