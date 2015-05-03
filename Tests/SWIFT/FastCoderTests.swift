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
    
    /*
            ((!lhs.array1 && !rhs.array1) || lhs.array1 == rhs.array1) &&
            ((!lhs.array2 && !rhs.array2) || lhs.array2 == rhs.array2)
*/
}



class FastCoderTests: XCTestCase {
    
    func runFastCoder(obj: Model) -> Model {
        var data = FastCoder.dataWithRootObject(obj)
        
        if data != nil {
            var newModel = FastCoder.objectWithData(data!) as? Model
            
            if newModel != nil {
                return newModel!
            } else {
                XCTFail("Result is nil")
            }
        }
        
        //XCTFail("Data is nil")
        assertionFailure("Data is nil")
        return Model()
    }
    
    func testChangingModel() {
        var rootObj = Model()
        rootObj.text = "foo"
        // array not supported
        
        var newModel = runFastCoder(rootObj)
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
        
        var newModel = runFastCoder(rootObj)
        //XCTAssertTrue(model == newModel, "Model not equal")
        XCTAssertEqual(rootObj, newModel, "Model not equal")
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
        
        var newModel = runFastCoder(rootObj)
        XCTAssertEqual(rootObj, newModel, "Model not equal")
        
    }
    
    
}

/**

- (void)testAliasing
{
    __strong Model *model = [[Model alloc] init];
    model.array1 = @[@1, @2];
    model.array2 = model.array1;
    
    //seralialize
    NSData *data = [FastCoder dataWithRootObject:model];
    
    //load as new model
    model = [FastCoder objectWithData:data];
    
    //check properties
    XCTAssertNotNil(model);
    XCTAssertEqualObjects(model.array1, model.array2);
    XCTAssertEqual(model.array1, model.array2);
    
    //now make them different but equal
    model.array2 = @[@1, @2];
    
    //seralialize
    data = [FastCoder dataWithRootObject:model];
    
    //load as new model
    model = [FastCoder objectWithData:data];
    
    //check properties
    XCTAssertEqualObjects(model.array1, model.array2);
    XCTAssertNotEqual(model.array1, model.array2);
}
*/

