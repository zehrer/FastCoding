//
//  FastCoder2Tests.swift
//  FastCoder
//
//  Created by Stephan Zehrer on 25.06.15.
//
//

import Cocoa
import FastCoding
import XCTest

class FastCoder2Tests: XCTestCase {
    
    func runFastCoder2<T: Encode>(element: T) -> T? {
        let data = FastCoder2.encodeRootElement(element)
        
        if data != nil {
            let obj : T? = FastCoder2.decodeRootElement(data!)
            
            if obj != nil {
                return obj!
            } else {
                XCTFail("Result is nil")
            }
        }
        
        XCTFail("Data is nil")
        //assertionFailure("Data is nil")
        return nil
    }

    func testBasicValueBool() {
        let input = true
        
        let output = runFastCoder2(input)
        
        XCTAssertTrue(input == output , "value not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
        
        // But in reality this return a NSNumber of "type" bool and not of type Integer as created
    }
    
    func testBasicValueInt() {
        let input = 42
        
        let output = runFastCoder2(input)
        
        XCTAssertTrue(input == output , "value not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
        
        // But in reality this return a NSNumber of "type" bool and not of type Integer as created
    }
    
    func testBasicValueUInt8() {
        let input : UInt8 = 42
        
        let output = runFastCoder2(input)
        
        XCTAssertTrue(input == output , "value not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
        
        // But in reality this return a NSNumber of "type" bool and not of type Integer as created
    }

}
