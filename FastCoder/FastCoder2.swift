//
//  FastCoder2.swift
//
//  Version 0.21
//
//  Created by Stephan Zehrer 05/05/2015
//  Copyright (c) 2015 Stephan Zehrer
//
// This (new) generation of FastCoder is derived from the FastCoder port from ObjC to Swift.
// The (inital) design goal here is a pure Swift version with a reduced feature set.
//
// Here a list of features version shall cover
//  - No dependencies to NSCoding but reuse the same pattern

// Here the list of supported features:
//  - Direct encode / decode of the following value types:
//    Bool, Int, UInt, Int8, UInt8, Flout, Double
//  - Support to decode integer with the minimum space (this has impact on the types)
//  - New Encoder & Decoder protocol
//  - Init support for Coding protocol instances 
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/zehrer/FastCoding
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import Foundation

public protocol Coding {
    
    //Only within the Initialization of an object it is possible
    // to set the value of a stored property if it is not optional
    init(coder aDecoder: Decode)
    
    func encodeWithCoder(coder : Encode)
}

public protocol Encode {
    
    // --- encode ---
    
    func encode(intv : Bool)
    func encode(intv : Bool?)
    
    func encode(intv : Int)
    func encode(intv : Int8)
    func encode(intv : Int16)
    func encode(intv : Int32)
    func encode(intv : Int64)
    
    func encode(intv : Int?)
    func encode(intv : Int8?)
    func encode(intv : Int16?)
    func encode(intv : Int32?)
    func encode(intv : Int64?)
    
    func encode(intv : UInt)
    func encode(intv : UInt8)
    func encode(intv : UInt16)
    func encode(intv : UInt32)
    func encode(intv : UInt64)
    
    func encode(intv : UInt?)
    func encode(intv : UInt8?)
    func encode(intv : UInt16?)
    func encode(intv : UInt32?)
    func encode(intv : UInt64?)
    
    func encode(realv: Float)
    func encode(realv: Double)
    
    func encode(realv: Float?)
    func encode(realv: Double?)
    
    func encode(strv: String)
    func encode(strv: String?)
    
    func encode(value : Coding)
    func encode(value : Coding?)
    
}

public protocol Decode {
    
    // --- decode ---
    
    func decode<T : Coding>() -> T?
    //func decode<T : Coding>() -> T
    
    func decode() -> Int?
    func decode() -> Int
    
}

public protocol FastCoder2 {
    func encode(coder: FC2Encoder)
}

/**

// does not work because self seems to have the wrong type of the extened class
extension FastCoder2 {
    public func encode(coder : FC2Encoder) {
        coder.encode(self)
    }
}
*/

extension Bool : FastCoder2 {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

extension Int : FastCoder2 {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

extension UInt : FastCoder2 {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

extension UInt8 : FastCoder2 {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

extension Float : FastCoder2 {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

extension Double : FastCoder2 {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

extension Coding {
    public func encode(coder: FC2Encoder) {
        coder.encode(self)
    }
}

/**

extension IntegerType {
public func encode(coder : FC2Encoder) {
coder.encode(self)
}
}

*/

public enum FC2Type : UInt8 {
    case Nil = 0
    case FCTypeObjectAlias8
    case FCTypeObjectAlias16
    case FCTypeObjectAlias32
    case FCTypeStringAlias8
    case FCTypeStringAlias16
    case FCTypeStringAlias32
    case String
    case FCTypeDictionary
    case FCTypeArray
    case FCTypeSet
    case True
    case False
    case Int
    case Int8
    case Int16
    case Int32
    case Int64
    case Float32
    case Float64
    case UInt
    case UInt8
    case UInt16
    case UInt32
    case UInt64
    case Coding
    case FCTypeData
    case FCTypeDate
    case FCTypeMutableData
    case FCTypeDecimalNumber
    case One
    case Zero
    case MinusOne
    case End
    
    case FCTypeUnknown
    
    // mark a end (e.g. end of a list)
    //case FCTypeClassDefinition
    //case FCTypeObject8
    //case FCTypeObject16
    //case FCTypeObject32
    //case FCTypeURL
    //case FCTypePoint
    //case FCTypeSize
    //case FCTypeRect
    //case FCTypeRange
    //case FCTypeVector
    //case FCTypeAffineTransform
    //case FCType3DTransform
}


public class FC2Encoder : Encode { //FC2Coder
    
    public var keeptIntType = true
    
    let UInt32max = UInt(UInt32.max)
    let UInt16max = UInt(UInt16.max)
    let UInt8max = UInt(UInt8.max)
    
    let Int32min = Int(Int32.min)
    let Int16min = Int(Int16.min)
    let Int8min = Int(Int8.min)
    
    // Key is a object, values are the related index
    var objectCache = Dictionary<NSObject,Index>()
    
    // Key is a string, value is the related index
    var stringCache = Dictionary<String,Index>()
    
    var encodeOutput = NSMutableData()
    
    /**
    init(_ data: NSMutableData) {
        encodeOutput = data
    }
    */
    
    public init () {
        
    }
    
    // MARK: encode methodes
    
    // Entry point for encoder
    
    public class func encodeRoot<T : FastCoder2>(element : T) -> NSData? {
        
        let encoder = FC2Encoder()
        return encoder.encodeRoot(element)
    }
    
    public class func encodeRoot<T : Coding>(element : T) -> NSData? {
        
        let encoder = FC2Encoder()
        return encoder.encodeRoot(element)
    }
    
    public func encodeRoot<T : FastCoder2>(element : T) -> NSData? {
        element.encode(self)
        
        if encodeOutput.length > 0 {
            return self.encodeOutput
        }
        return nil
    }
    
    public func encodeRoot<T : Coding>(element : T) -> NSData? {
        element.encode(self)
        
        if encodeOutput.length > 0 {
            return self.encodeOutput
        }
        return nil
    }
    
    /**
    // move the entry point directly to the encoder and remove FastCoder2
    func encodeRoot<T>(element : T) {
        

    }
    */
    



    
    public func encode(boolv : Bool) {
        if boolv {
            writeType(.True)
        } else {
            writeType(.False)
        }
    }
    
    public func encode(boolv : Bool?) {
    }
    

    
    public func encode(intv : Int8) {
        //direct encodeing -> no cache
        writeType(.Int8)
        writeValue(intv)
    }
    
    public func encode(intv: Int16) {
        //direct encodeing -> no cache
        writeType(.Int16)
        writeValue(intv)
    }
    
    public func encode(intv: Int32) {
        //direct encodeing -> no cache
        writeType(.Int32)
        writeValue(intv)
    }
    
    public func encode(intv : Int64) {
        //direct encodeing -> no cache
        writeType(.Int64)
        writeValue(intv)
    }
    
    
    public func encode(intv : Int8?) {
        //direct encodeing -> no cache
        writeType(.Int8)
        writeValue(intv)
    }
    
    public func encode(intv: Int16?) {
        //direct encodeing -> no cache
        writeType(.Int16)
        writeValue(intv)
    }
    
    public func encode(intv: Int32?) {
        //direct encodeing -> no cache
        writeType(.Int32)
        writeValue(intv)
    }
    
    public func encode(intv : Int64?) {
        //direct encodeing -> no cache
        writeType(.Int64)
        writeValue(intv)
    }
    
    
    public func encode(intv : UInt8) {
        //direct encodeing -> no cache
        writeType(.UInt8)
        writeValue(intv)
    }
    
    public func encode(intv: UInt16) {
        //direct encodeing -> no cache
        writeType(.UInt16)
        writeValue(intv)
    }
    
    public func encode(intv: UInt32) {
        //direct encodeing -> no cache
        writeType(.UInt32)
        writeValue(intv)
    }
    
    public func encode(intv : UInt64) {
        //direct encodeing -> no cache
        writeType(.UInt64)
        writeValue(intv)
    }
    
    public func encode(intv : UInt8?) {
        //direct encodeing -> no cache
        writeType(.UInt8)
        writeValue(intv)
    }
    
    public func encode(intv: UInt16?) {
        //direct encodeing -> no cache
        writeType(.UInt16)
        writeValue(intv)
    }
    
    public func encode(intv: UInt32?) {
        //direct encodeing -> no cache
        writeType(.UInt32)
        writeValue(intv)
    }
    
    public func encode(intv : UInt64?) {
        //direct encodeing -> no cache
        writeType(.UInt64)
        writeValue(intv)
    }
    
    public func encode(realv : Float) {
        //direct encodeing -> no cache
        writeType(.Float32)
        writeValue(realv)
    }
    
    public func encode(realv : Double) {
        //direct encodeing -> no cache
        writeType(.Float32)
        writeValue(realv)
    }
    
    public func encode(realv : Float?) {
        //direct encodeing -> no cache
        writeType(.Float32)
        writeValue(realv)
    }
    
    public func encode(realv : Double?) {
        //direct encodeing -> no cache
        writeType(.Float32)
        writeValue(realv)
    }
    

    
    public func encode(intv : Int) {
        //direct encodeing -> no cache
        if keeptIntType {
            writeType(.Int)
            writeValue(intv)
        } else {
            if intv < 0 {
                switch intv {
                case -1:
                    writeType(.MinusOne)
                case Int8min...0:
                    encode(Int8(intv))
                case Int16min...Int8min:
                    encode(Int16(intv))
                case Int32min...Int16min:
                    encode(Int32(intv))
                default:
                    encode(Int64(intv))
                }
            } else {
                // possitive numbers are more efficient encoded in UInt
                encode(UInt(intv))
            }
        }
    }
    
    public func encode(intv : Int?) {
    }
    
    public func encode(intv : UInt) {
        //direct encodeing -> no cache
        if keeptIntType {
            writeType(.UInt)
            writeValue(intv)
        } else {
            switch intv {
            case UInt16max...UInt32max:
                encode(UInt32(intv))
            case UInt8max...UInt16max:
                encode(UInt16(intv))
            case 0:
                writeType(.Zero)
            case 1:
                writeType(.One)
            case 1...UInt8max:
                encode(UInt8(intv))
            default:
                encode(UInt64(intv))
            }
        }
    }
    
    public func encode(intv : UInt?) {
    }
    

    
    public func encode(strv: String) {
        
    }
    
    public func encode(strv: String?) {
        
    }
    
    public func encode(element: Coding) {
        writeType(.Coding)
        //writeString(className / sturctName)
        element.encodeWithCoder(self)
        writeType(.End)
    }
    
    public func encode(value : Coding?) {
        
    }
    
    
    /**
    
    func encode(obj: NSCoding) {
    
    }
    */
    
    func encode(element : Any) {
        assertionFailure("Unsupported Root Element")
    }
    
    // MARK: WriteMethodes
    
    func writeValue<T>(value : T) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(T))
    }
    
    func writeString(string : String) {
        //if FastCoder.FCWriteStringAlias(self, coder: aCoder) { return }
        //aCoder.FCCacheWrittenString(self)
        writeType(.String)
        encodeOutput.appendEncodedString(string)
    }
    
    func writeType(type : FC2Type) {
        writeValue(type.rawValue)
    }
    
    // MARK: Protocol
    
    /**
    
    public override func encodeValue(intv: Int8?, forKey key: String) {
        if intv != nil {
            writeType(.Int8)
            writeValue(intv)
        } else {
            writeType(.Nil)
        }
        
        writeString(key)

    }
    */
}

public class FC2Decoder : Decode {
    
    // Key is a object, values are the related index
    //var objectCache = Dictionary<NSObject,Index>()
    var objectCache = Array<Any>()
    
    // Key is a string, value is the related index
    
    //var stringCache = Dictionary<String,Index>()
    var stringCache = Array<String>()
    
    var properties = Dictionary<String,Any>()
    
    // data for NSRange
    
    var data : NSData
    
    var location = 0
    
    public init(_ data: NSData) {
        self.data = data
    }
    
    func getDataSection(length : Int) -> NSData {
        let range =  NSRange(location: location, length: length)
        
        location += length
        
        return data.subdataWithRange(range)
    }
    
    // return string lengh at current location (incl. zero termination)
    func stringDataLength() -> UInt {
        let utf8 = UnsafePointer<Int8>(data.bytes + location)
        return strlen(utf8) + 1 // +1 for zero termination
    }
    
    // MARK: DECODE
    
    public class func decodeRoot<T>(data : NSData) -> T? {
        
        let decoder = FC2Decoder(data)
        
        return decoder.decodeRoot()
    }
    
    public func decodeRoot<T>() -> T? {
        
        let type = readType()
        
        return readInstance(type) as? T

    }
    
    public func decodeRoot() -> Any? {
        
        let type = readType()
        
        return readInstance(type)
    }
    
    

    public func decode<T : Coding>() -> T? {
        
        let type = readType()
        
        if type == .Coding {
            return T.init(coder:self)
        }
        
        return nil
    }
    
    
    /**
    public func decode<T : Coding>() -> T {
        
        let value : Coding? = decode()
        
        if value != nil {
            return value!
        }
        
        assertionFailure("read optional value")
        
        return T.init(coder:self)
    }
    */
    
    

    public func decode() -> Int? {
        
        let type = readType()
        
        var result = 0
        
        switch type {
        case .Nil:
            return nil
        case .Int:
            result = readInt()
        case .Int8:
            result = Int(readInt8())
        case .Int16:
            result = Int(readInt16())
        case .Int32:
            result = Int(readInt32())
        case .Int64:
            result = Int(readInt64())
        case .Float32:
            result = Int(readFloat32())
        case .Float64:
            result = Int(readFloat64())
        case .UInt8:
            result = Int(readUInt8())
        case .UInt16:
            result = Int(readUInt16())
        case .UInt32:
            result = Int(readUInt32())
        case .UInt64:
            result = Int(readUInt64())
        case .One:
            return 1
        case .Zero:
            return 0
        case .MinusOne:
            return -1
        default:
            assertionFailure("Not supported type")
            
        }
        
        return result
    }
    
    public func decode() -> Int {
        let value : Int? = decode()
        
        if value != nil {
            return value!
        }
        
        assertionFailure("read optional value")
        
        return 0
    }
    

    
    public func decode() -> Any? {
        
        let type = readType()
        
         return readInstance(type)
    }
    
    public func decodeInt() -> Int? {
        let type = readType()
        
        switch type {
        case .Int:
            return readInt()
        case .Int8:
            return Int(readInt8())
        case .Int16:
            return Int(readInt16())
        case .Int32:
            return Int(readInt32())
        case .Int64:
            return Int(readInt64())
        case .UInt8:
            return Int(readUInt8())
        case .UInt16:
            return Int(readUInt16())
        case .UInt32:
            return Int(readUInt32())
        case .UInt64:
            return Int(readUInt64())
        default:
            return nil
        }
    }
    
    // MARK: READ
    
    func readInstance(type: FC2Type) -> Any? {
        
        switch type {
        case .Nil:
            return nil
            //  case .FCTypeObjectAlias8:
            //      return readAlias8()
            //  case .FCTypeObjectAlias16:
            //      return readAlias16()
            //  case .FCTypeObjectAlias32:
            //      return readAlias32()
        case .FCTypeStringAlias8:
            return readStringAlias8()
        case .FCTypeStringAlias16:
            return readStringAlias16()
        case .FCTypeStringAlias32:
            return readStringAlias32()
        case .String:
            return readString()
            //case .FCTypeDictionary:
            //      return readDictionary()
            //case .FCTypeArray:
            //      return readArray()
            //case .FCTypeSet:
            //      return readSet()
        case .True:
            return true
        case .False:
            return false
        case .Int:
            return readInt()
        case .Int8:
            return readInt8()
        case .Int16:
            return readInt16()
        case .Int32:
            return readInt32()
        case .Int64:
            return readInt64()
        case .Float32:
            return readFloat32()
        case .Float64:
            return readFloat64()  // Double
        case .UInt8:
            return readUInt8()
        case .UInt16:
            return readUInt16()
        case .UInt32:
            return readUInt32()
        case .UInt64:
            return readUInt64()
        case .Coding:
            return read
            //case .FCTypeObject:
            //    return readObject()
            //case FCTypeDate
            //case FCTypeData
            //case FCTypeMutableData
            //case FCTypeDecimalNumber
        case .One:
            return 1
        case .Zero:
            return 0
        case .MinusOne:
            return -1
        case .End:
            assertionFailure("Error: end type on the wrong place")
        case .FCTypeUnknown:
            assertionFailure("Error during encoding, unknown type found")
        default:
            assertionFailure("Not supported type")
            
        }
        
        return nil
    }

    func readValue<T>(inout value:T) {
        let size = sizeof(T)
        let data = getDataSection(size)
        data.getBytes(&value, length:size)
    }
    
    func readType() -> FC2Type {
        
        var value : UInt8 = 0
        readValue(&value)
        
        let type = FC2Type(rawValue: value)
        
        if type != nil  {
            return type!
        }
        
        return .FCTypeUnknown
    }
    
    func readUInt() -> UInt {
        var value : UInt = 0
        readValue(&value)
        
        return value
    }
    
    func readUInt8() -> UInt8 {
        var value : UInt8 = 0
        readValue(&value)
        
        return value
    }
    
    func readUInt16() -> UInt16 {
        
        var value : UInt16 = 0
        readValue(&value)
        
        return value
    }
    
    func readUInt32() -> UInt32 {
        
        var value : UInt32 = 0
        readValue(&value)
        
        return value
    }
    
    func readUInt64() -> UInt64 {
        
        var value : UInt64 = 0
        readValue(&value)
        
        return value
    }
    
    func readRawString() -> String? {
        
        // get the data size of the string
        let stringLength = stringDataLength() // data.stringDataLength(offset: decoder.location)
        let stringData = getDataSection(Int(stringLength))
        
        if stringLength > 1 {
            
            return stringData.decodeStringData()
        }
        
        return ""
    }
    
    /**
    func readAlias8() -> AnyObject {
        let index = readUInt8()
        
        return objectCache[Int(index)]
    }
    
    func readAlias16() -> AnyObject {
        let index = readUInt16()
        
        return objectCache[Int(index)]
    }
    
    func readAlias32() -> AnyObject {
        let index = readUInt32()
        
        return objectCache[Int(index)]
    }
    */

    func readStringAlias8() -> String {
        let index = readUInt8()
        
        return stringCache[Int(index)]
    }
    
    func readStringAlias16() -> String {
        let index = readUInt16()
        
        return stringCache[Int(index)]
    }
    
    func readStringAlias32() -> String {
        let index = readUInt32()
        
        return stringCache[Int(index)]
    }
    
    func readString() -> String {
        let string = readRawString()
        
        if string != nil {
            stringCache.append(string!)
            return string!
        }
        
        assertionFailure("ReadRaw should never return a nil string")
        return ""
    }
    
    func readObject<O : Coding>() -> O {
        
        let className = readString()
        let oldProperties = properties
        
        properties = Dictionary()
        
        while (true) {
            // read all elements as input for initWithCoder:
            let type = readType()
            
            if type == .End {
                break;
            } // list termination
            
            let instance = readInstance(type)
            let key = readString()
            properties[key] = instance
        }
        
        let objClass = NSClassFromString(className) as? O.Type

        let object = objClass!.init(coder: self)
        
        objectCache.append(object)
        
        properties = oldProperties
        
        return object
    }
    
    func readInt() -> Int {
        var value : Int = 0
        readValue(&value)
        
        return value
    }
    
    func readInt8() -> Int8 {
        var value : Int8 = 0
        readValue(&value)
        
        return value
        
    }
    
    func readInt16() -> Int16 {
        var value : Int16 = 0
        readValue(&value)
        
        return value
    }
    
    func readInt32() -> Int32 {
        var value : Int32 = 0
        readValue(&value)
        
        return value
    }
    
    func readInt64() -> Int64 {
        var value : Int64 = 0
        readValue(&value)
        
        return value
    }
    
    func readFloat32() -> Float32 {
        var value : Float32 = 0
        readValue(&value)
        
        return value
    }
    
    func readFloat64() -> Double {
        var value : Double = 0
        readValue(&value)
        
        return value
    }
    
    func readInstance() -> Any {
        let type = readType()
        
        return readInstance(type)
        
    }
    
    // MARK: Protocol
    
    


}




/**
extension NSMutableData {
    
    func appendEncodedString(string: NSString) {
        // encode with "dataUsingEncoding"
        var zero : UInt8 = 0
        
        //var mutableData = NSMutableData()
        
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        
        if data != nil {
            self.appendData(data!)
        }
        
        // write zero termination
        self.appendBytes(&zero, length: sizeof(UInt8))
        
    }
}
*/

