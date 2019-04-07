//
//  RxTestTests.swift
//  RxTestTests
//
//  Created by khayashida on 2019/04/02.
//  Copyright © 2019 khayashida. All rights reserved.
//

import XCTest
@testable import RxTest

class RxTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testtapAction() {
        let viewModel = ViewModel()
        
        viewModel.input.accept("6660017")
        viewModel.tapAction()
        
        let result = """{
            "message": null,
            "results": [
            {
            "address1": "兵庫県",
            "address2": "川西市",
            "address3": "火打",
            "kana1": "ﾋｮｳｺﾞｹﾝ",
            "kana2": "ｶﾜﾆｼｼ",
            "kana3": "ﾋｳﾁ",
            "prefcode": "28",
            "zipcode": "6660017"
            }
            ],
            "status": 200
        }"""
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
