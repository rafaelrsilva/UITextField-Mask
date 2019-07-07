//
//  NumberMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class NumberMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .number)
    }
    
    func testUsingValidInput() {
        field.text = "123456"
        XCTAssertEqual(field.text, "123456", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "123456", "Field value unmasked incorrectly")
    }
}
