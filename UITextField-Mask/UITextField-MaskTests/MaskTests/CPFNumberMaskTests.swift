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
}
