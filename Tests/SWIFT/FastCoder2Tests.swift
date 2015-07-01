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


struct TestStruct : Coding {
    
    var value = 42
    
    init() {
        
    }
    
    init(coder decoder: Decode) {
        value = decoder.decode()
    }
    
    func encodeWithCoder(coder : Encode) {
        coder.encode(value)
    }
}

func == (l : TestStruct, r: TestStruct) -> Bool {
    return l.value == r.value
}

class FastCoder2Tests: XCTestCase {
    
    func runFastCoder2<T: FastCoder2>(element: T) -> T? {
        
        let data = FC2Encoder.encodeRoot(element)
        
        if data != nil {
            print("Data size . \(data!.length)")
            
            let obj : T? = FC2Decoder.decodeRoot(data!)
            
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
    
    // encode 64 bit
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
    
    func testBasicValueUInt8_short() {

        let input = 42
        let encoder = FC2Encoder()
        encoder.keeptIntType = false
        
        let data = encoder.encodeRoot(input)
        
        if data != nil {
            
            print("Data size . \(data!.length)")
            let decoder = FC2Decoder(data!)
            
            let output : Int = decoder.decode()
            
            XCTAssertTrue(input == output , "value not equal")
            
        }
    }
    
    func testValue() {
        var input = TestStruct()
        input.value = 100
        
        let data = FC2Encoder.encodeRoot(input)
        
        if data != nil {
            print("Data size . \(data!.length)")
            
            let decoder = FC2Decoder(data!)
        
            let output : TestStruct? =  decoder.decode()
            
            XCTAssertTrue(input == output! , "value not equal")
            
        }
        
    }
    

}
