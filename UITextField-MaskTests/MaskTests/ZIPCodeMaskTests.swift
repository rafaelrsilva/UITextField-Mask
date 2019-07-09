//
//  ZIPCodeMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class ZIPCodeMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .zipCode)
    }
    
    func testUsingValidInput() {
        field.text = "01234567"
        XCTAssertEqual(field.text, "01234-567", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "01234567", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "01234-567"
        XCTAssertEqual(field.text, "01234-567", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "01234567", "Field value unmasked incorrectly")
    }
}
