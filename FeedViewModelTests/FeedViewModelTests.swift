//
//  FeedViewModelTests.swift
//  FeedViewModelTests
//
//  Created by Виталий Мишин on 15.07.2024.
//

import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {
    
    var feed: FeedViewModel = .init()
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFeedViewModel () throws {
        
        XCTAssertEqual(feed.secretWord, "Amur".localized)
        XCTAssertEqual(feed.status, nil)
        //проверка секретного слова, корректное
        feed.check(inputSecretWord: "Amur".localized)
        
        XCTAssertEqual(feed.secretWord, "Amur".localized)
        XCTAssertEqual(feed.status, "correct".localized)
        //проверка секретного слова, некорректное
        feed.check(inputSecretWord: "NonAmur".localized)
        
        XCTAssertEqual(feed.secretWord, "Amur".localized)
        XCTAssertEqual(feed.status, "not_correct".localized)
    }
    
    
    
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //        // Any test you write for XCTest can be annotated as throws and async.
    //        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    //        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    //
}
