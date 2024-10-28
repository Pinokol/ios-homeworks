//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Виталий Мишин on 15.07.2024.
//

import XCTest
@testable import Navigation


final class LoginInspectorTests: XCTestCase {
    
    var inspector: LoginInspector!
    
    override func setUpWithError() throws {
        inspector = LoginInspector()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        inspector = nil
    }
    
    func testLoginInspector () throws {
        
        let result = inspector.isValidEmail("test@test.test")
        
        XCTAssertTrue(result)
    }
    //проверка на корректный e-mail
    
    func testLoginInspector1 () throws {
        
        let result1 = inspector.isValidEmail("test")
        
        XCTAssertFalse(result1)
        
    }
    
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

//}
