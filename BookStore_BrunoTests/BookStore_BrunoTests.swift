//
//  BookStore_BrunoTests.swift
//  BookStore_BrunoTests
//
//  Created by BRUNO VASCONCELOS on 18/12/2020.
//

import XCTest
@testable import BookStore_Bruno

class BookStore_BrunoTests: XCTestCase {

    private var service: BooksDataSourceType!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        self.service = BooksDataSource()
        
        self.service.fetchBooks(name: "ios") { result in
            switch result {
            case .failure:
                XCTAssert(false, "Something went wrong")
            case .success(_):
                XCTAssert(true, "All good")
            }
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
