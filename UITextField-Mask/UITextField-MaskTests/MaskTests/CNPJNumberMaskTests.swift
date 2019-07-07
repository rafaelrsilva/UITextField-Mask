//
//  CNPJNumberMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class CNPJNumberMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .cnpjNumber)
    }
    
    func testUsingValidInput() {
        field.text = "90919856000158"
        XCTAssertEqual(field.text, "90.919.856/0001-58", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "90919856000158", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "90.919.856/0001-58"
        XCTAssertEqual(field.text, "90.919.856/0001-58", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "90919856000158", "Field value unmasked incorrectly")
    }
}
