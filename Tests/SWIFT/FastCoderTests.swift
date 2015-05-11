//
//  FastCoderTests.swift
//  FastCoderTests
//
//  Created by Stephan Zehrer on 22.04.15.
//
//

import Cocoa
import FastCoding
//import FastCoder
import XCTest



class Model : NSObject, NSCoding, Equatable{
    var text = ""
    //var array1 = NSArray()
    //var array2 = NSArray()

    var nextObj1 : Model? = nil
    var nextObj2 : Model? = nil
    weak var prevObj : Model? = nil
    
    var  int8 : Int8 = Int8.max
    var  int16 : Int16 = Int16.max
    var  int32 : Int32 = Int32.max
    var  int64 : Int64 = Int64.max
    
    var  intv : Int = Int.max
    
    var bool : Bool = true
    
    required override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("1") as! String
        nextObj1 = aDecoder.decodeObjectForKey("2") as? Model
        nextObj2 = aDecoder.decodeObjectForKey("3") as? Model
        prevObj = aDecoder.decodeObjectForKey("4") as? Model
        
        bool = aDecoder.decodeBoolForKey("b")
        int32 = aDecoder.decodeInt32ForKey("i32")
        int64 = aDecoder.decodeInt64ForKey("i64")
        intv = aDecoder.decodeIntegerForKey("int")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "1")
        aCoder.encodeObject(nextObj1, forKey: "2")
        aCoder.encodeObject(nextObj2, forKey: "3")
        aCoder.encodeObject(prevObj, forKey: "4")
        
        aCoder.encodeBool(bool, forKey:"b")
        aCoder.encodeInt32(int32, forKey: "i32")
        aCoder.encodeInt64(int64, forKey: "i64")
        aCoder.encodeInteger(intv, forKey: "int")
    }
}


func ==(lhs: Model  , rhs: Model) -> Bool {
    return  lhs.text == rhs.text &&
    ((lhs.nextObj1 == nil && rhs.nextObj1 == nil) || (lhs.nextObj1! == rhs.nextObj1! )) &&
    ((lhs.nextObj2 == nil && rhs.nextObj2 == nil) || (lhs.nextObj2! == rhs.nextObj2! )) &&
    ((lhs.prevObj == nil && rhs.prevObj == nil) || (lhs.prevObj != nil && rhs.prevObj != nil))

    // TODO: nextObj1, ... may be nil
    
    //

}


class FastCoderTests: XCTestCase {
    
    func runFastCoder(obj: NSObject) -> NSObject {
        var data = FastCoder.dataWithRootObject(obj)
        
        if data != nil {
            var obj = FastCoder.objectWithData(data!)
            
            if obj != nil {
                return obj!
            } else {
                XCTFail("Result is nil")
            }
        }
        
        //XCTFail("Data is nil")
        assertionFailure("Data is nil")
        return ""
    }
    
    func testChangingModel() {
        var rootObj = Model()
        rootObj.text = "foo"
        // array not supported
        
        var newModel = runFastCoder(rootObj) as! Model
        
        //XCTAssertTrue(model == newModel, "Model not equal")
        XCTAssertEqual(rootObj, newModel, "Model not equal")

    }
    
    // the current implementation is not able to handle cycles
    // both FastCoder Swift & FastCoder ObjC
    
    /**
    func testObjectCycles() {
        var rootObj = Model()
        var subObj = Model()
        rootObj.nextObj1 = subObj
        subObj.prevObj = rootObj
        
        var newModel = runFastCoder(rootObj) as! Model
        
        //XCTAssertTrue(model == newModel, "Model not equal")
        XCTAssertEqual(rootObj, newModel, "Model not equal")
    }
    */
    
    //
    func testObjectCycles2() {
        var rootObj = Model()
        var subObj = Model()
        rootObj.nextObj1 = subObj
        subObj.prevObj = rootObj
        
        var data = NSKeyedArchiver.archivedDataWithRootObject(rootObj)
        var newModel = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Model
        
        XCTAssertTrue(rootObj == newModel, "Model not equal")
        //XCTAssertEqual(rootObj, newModel!, "Model not equal")
    }
    
    func testAliasing() {
        var rootObj = Model()
        var obj1 = Model()
        rootObj.nextObj1 = obj1
        var obj2 = Model()
        rootObj.nextObj2 = obj2
        var obj3 = Model()
        obj1.nextObj1 = obj3
        obj2.nextObj1 = obj3
        
        var newModel = runFastCoder(rootObj) as! Model
        XCTAssertEqual(rootObj, newModel, "Model not equal")
        
    }
    
    func testAliasingWithSubstitution() {
        var rootObj = Model()
        var array = NSMutableArray()
        array.addObject(rootObj)
        array.addObject(rootObj)
        
        //var array = [rootObj, rootObj]
        
        var newModel = runFastCoder(array) as! NSArray
        var o1 = newModel[0] as! Model
        var o2 = newModel[1] as! Model
        
        //XCTAssertEqual(o1, o2, "Not the same obj")
        XCTAssertTrue(o1 === o2, "Model not identical")
        XCTAssertEqual(rootObj, o1, "Model not equal")
        XCTAssertEqual(rootObj, o2, "Model not equal")
    }
    
    func testBooleans() {
        var input = NSNumber(int: 1)
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
        
        // But in reality this return a NSNumber of "type" bool and not of type Integer as created
    }
    
    func testInt8() {
        var input = NSNumber(char: Int8.max)
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
    }
    
    func testInt16() {
        var input = NSNumber(short: Int16.max)
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
    }
    
    func testInt32() {
        var input = NSNumber(int: Int32.max)
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
    }
    
    func testInt64() {
        var input = NSNumber(longLong: Int64.max)
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
    }

    // encode as "Q" -> correct
    func testUInt64() {
        var input = NSNumber(unsignedLongLong: UInt64.max)
        
        let type  = String.fromCString(input.objCType)!
        println("type: \(type)")
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
    }
    
    // encode as "q" not as "L"
    func testUInt32() {
        var input = NSNumber(unsignedInt: UInt32.max)
        
        let type  = String.fromCString(input.objCType)!
        println("type: \(type)")
        
        var output = runFastCoder(input)
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
    }
    
    
    // encode as "i" not as "S"
    func testUInt16() {
        var input = NSNumber(unsignedShort: UInt16.max)
        
        let type  = String.fromCString(input.objCType)!
        println("type: \(type)")
        
        var output = runFastCoder(input) as! NSNumber
        
        XCTAssertTrue(input == output , "object not equal")
        XCTAssertTrue(input.self == output.self, "Type not similar")
        
    }
    
    func testDate() {
        let date = NSDate(timeIntervalSinceReferenceDate: 118800)
        
        var output = runFastCoder(date) as! NSDate
        
        XCTAssertTrue(date == output, "Data is equal")
    }
    
    func testNSData() {
        var num1 = NSNumber(unsignedLongLong: UInt64.max)
        let data = "TEST".dataUsingEncoding(NSUTF8StringEncoding)
        var num2 = NSNumber(unsignedLongLong: UInt64.max)
        
        var array = NSMutableArray()
        array.addObject(num1)
        array.addObject(data!)
        array.addObject(num2)
        
        var output = runFastCoder(array) as! NSArray
        
        var o1 = output[1] as! NSData

        
        XCTAssertTrue(o1 == data, "Data is equal")
        
    }
    

}

