//
//  DateEndingWithYearMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class DateEndingWithYearMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .dateEndingWithYear)
    }
    
    func testUsingValidInput() {
        field.text = "06072019"
        XCTAssertEqual(field.text, "06/07/2019", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "06072019", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "06/07/2019"
        XCTAssertEqual(field.text, "06/07/2019", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "06072019", "Field value unmasked incorrectly")
    }
}
