//
//  TelephoneMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class TelephoneMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .telephone)
    }
    
    func testUsingValidInput() {
        field.text = "1123456789"
        XCTAssertEqual(field.text, "(11) 2345-6789", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "1123456789", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "(11) 2345-6789"
        XCTAssertEqual(field.text, "(11) 2345-6789", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "1123456789", "Field value unmasked incorrectly")
    }
}
