//
//  DateStartingWithYearMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class DateStartingWithYearMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .dateStartingWithYear)
    }
    
    func testUsingValidInput() {
        field.text = "20190706"
        XCTAssertEqual(field.text, "2019/07/06", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "20190706", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "2019/07/06"
        XCTAssertEqual(field.text, "2019/07/06", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "20190706", "Field value unmasked incorrectly")
    }
}
