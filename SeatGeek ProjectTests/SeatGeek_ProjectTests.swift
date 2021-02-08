//
//  SeatGeek_ProjectTests.swift
//  SeatGeek ProjectTests
//
//  Created by Molly Lowder on 02/05/21.
//

import XCTest
@testable import SeatGeek_Project

class SeatGeek_ProjectTests: XCTestCase {
    

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
       
        try super.tearDownWithError()
    }

    func testFormingURLFromSearchBar()  {
        // Given
        
        
        // When
        
        
        // Then
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension XCTestCase {
    enum TestError: Error {
        case fileNotFound
    }
    
    func getData(fromJSON fileName: String) throws -> Data {
        let bundle = Bundle(for:type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing File:  \(fileName).json")
            throw TestError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw error
        }
    }
}
