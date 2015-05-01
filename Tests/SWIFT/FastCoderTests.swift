//
//  FastCoderTests.swift
//  FastCoderTests
//
//  Created by Stephan Zehrer on 22.04.15.
//
//

import Cocoa
//import FastCoding
import FastCoder
import XCTest


class Model : NSObject, NSCoding, Equatable{
    var text = ""
    //var array1 = NSArray()
    //var array2 = NSArray()

    var nextObj : Model? = nil
    weak var prevObj : Model? = nil
    
    required override init() {
        
    }
    
    required init(prevObj : Model) {
        self.prevObj = prevObj
        super.init()
        prevObj.nextObj = self
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("1") as! String
        nextObj = aDecoder.decodeObjectForKey("2") as? Model
        prevObj = aDecoder.decodeObjectForKey("3") as? Model
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "1")
        aCoder.encodeObject(nextObj, forKey: "2")
        aCoder.encodeObject(prevObj, forKey: "3")
    }
}


func ==(lhs: Model  , rhs: Model) -> Bool {
    return lhs.text == rhs.text &&
    lhs.nextObj === rhs.nextObj &&
    lhs.prevObj === rhs.prevObj
    
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
    
    func testAliasing() {
        var rootObj = Model()
        var obj1 = Model(prevObj: rootObj)
        
        var newModel = runFastCoder(rootObj)
        //XCTAssertTrue(model == newModel, "Model not equal")
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

