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
    
    required override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("1") as! String
        nextObj1 = aDecoder.decodeObjectForKey("2") as? Model
        nextObj2 = aDecoder.decodeObjectForKey("3") as? Model
        prevObj = aDecoder.decodeObjectForKey("4") as? Model
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "1")
        aCoder.encodeObject(nextObj1, forKey: "2")
        aCoder.encodeObject(nextObj2, forKey: "3")
        aCoder.encodeObject(prevObj, forKey: "4")
    }
}


func ==(lhs: Model  , rhs: Model) -> Bool {
    return lhs.text == rhs.text &&
    lhs.nextObj1 == rhs.nextObj1 &&
    lhs.nextObj2 == rhs.nextObj2 &&
    lhs.prevObj == rhs.prevObj
    
    /**
    nil handling not required, no optionals as input
    */
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
    func testObjectCycles() {
        var rootObj = Model()
        var subObj = Model()
        rootObj.nextObj1 = subObj
        subObj.prevObj = rootObj
        
        var newModel = runFastCoder(rootObj) as! Model
        
        //XCTAssertTrue(model == newModel, "Model not equal")
        XCTAssertEqual(rootObj, newModel, "Model not equal")
    }
    
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
    
}

/**
- (void)testAliasingWithSubstitution
{
    Model *model = [[Model alloc] init];
    NSArray *array = @[model, model];
    
    //seralialize
    NSData *data = [FastCoder dataWithRootObject:array];
    
    //deserialize
    array = [FastCoder objectWithData:data];
    
    //check properties
    XCTAssertEqual(array[0], array[1]);
}

*/

