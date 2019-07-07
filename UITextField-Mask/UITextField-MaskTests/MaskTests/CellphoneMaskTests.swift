//
//  CellphoneMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class CellphoneMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .cellphone)
    }
    
    func testUsingValidInput() {
        field.text = "11999998888"
        XCTAssertEqual(field.text, "(11) 99999-8888", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "11999998888", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "(11) 99999-8888"
        XCTAssertEqual(field.text, "(11) 99999-8888", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "11999998888", "Field value unmasked incorrectly")
    }
}
