//
//  CPFNumberMaskTests.swift
//  UITextField-MaskTests
//
//  Created by Rafael on 06/07/19.
//  Copyright © 2019 Rafael Ribeiro da Silva. All rights reserved.
//

import XCTest
import UIKit

final class CPFNumberMaskTests: MaskBaseTest {

    override func setUp() {
        super.setUp()
        field.maskField(with: .cpfNumber)
    }
    
    func testUsingValidInput() {
        field.text = "62931190020"
        XCTAssertEqual(field.text, "629.311.900-20", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "62931190020", "Field value unmasked incorrectly")
    }
    
    func testUsingValidMaskedInput() {
        field.text = "629.311.900-20"
        XCTAssertEqual(field.text, "629.311.900-20", "Input masked incorrectly")
        XCTAssertEqual(field.unmaskedText, "62931190020", "Field value unmasked incorrectly")
    }
}
