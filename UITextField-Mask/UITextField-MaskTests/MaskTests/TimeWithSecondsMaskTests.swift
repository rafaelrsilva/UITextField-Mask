//
//  TimeWithSecondsMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class TimeWithSecondsMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .timeWithSeconds)
    }
    
    func testUsingValidInput() {
        field.text = "235859"
        XCTAssertEqual(field.text, "23:58:59", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "235859", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "23:58:59"
        XCTAssertEqual(field.text, "23:58:59", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "235859", "Field value unmasked incorrectly")
    }
}
