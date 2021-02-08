//
//  SeatGeek_ProjectTests.swift
//  SeatGeek ProjectTests
//
//  Created by Molly Lowder on 02/05/21.
//

import XCTest
@testable import SeatGeek_Project
var viewController: ViewController!

class SeatGeek_ProjectTests: XCTestCase {
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = ViewController()
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    }

    func testIfApiPullIsSuccessfulWithin5Seconds()  {
        // Given
        let maxTimeForApiPull = 5.0
        
        // When
        viewController.fetchAllEvents()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + maxTimeForApiPull) {
            XCTAssertGreaterThan(viewController.events.count, 0, "SeatGeek API call was unsuccessful and did not retrieve any data")
        }
        
    }

}

extension XCTestCase {
    enum TestError: Error {
        case fileNotFound
    }
    

}
