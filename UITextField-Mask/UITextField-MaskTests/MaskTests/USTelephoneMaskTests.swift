//
//  USTelephoneMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class USTelephoneMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .usTelephone)
    }
    
    func testUsingValidInput() {
        field.text = "2186433341"
        XCTAssertEqual(field.text, "(218) 643-3341", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "2186433341", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "(218) 643-3341"
        XCTAssertEqual(field.text, "(218) 643-3341", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "2186433341", "Field value unmasked incorrectly")
    }
}
