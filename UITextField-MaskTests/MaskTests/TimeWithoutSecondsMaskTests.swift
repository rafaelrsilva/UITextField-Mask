//
//  TimeWithoutSecondsMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class TimeWithoutSecondsMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .timeWithoutSeconds)
    }
    
    func testUsingValidInput() {
        field.text = "2358"
        XCTAssertEqual(field.text, "23:58", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "2358", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "23:58"
        XCTAssertEqual(field.text, "23:58", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "2358", "Field value unmasked incorrectly")
    }
}
