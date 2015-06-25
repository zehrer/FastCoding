//
//  FastCoder2.swift
//
//  Version 0.1
//
//  Created by Stephan Zehrer 05/05/2015
//  Copyright (c) 2015 Stephan Zehrer
//
// This (new) generation of FastCoder is derived from the FastCoder port from ObjC to Swift.
// The (inita) design goal here is a pure Swift version but with a reduced feature set.
//
// Here a list of features version shall cover
//  - No dependencies to NSCoding but reuse the same pattern
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
    init(coder aDecoder: FCoder)
    
    func encodeWithCoder(aCoder: FCoder)
}

public protocol FCoder {
    
    func encodeObject(objv: AnyObject?, forKey key: String)
    func encodeObject(data: NSData, forKey key: String)
    
    func encodeValue(boolv: Bool?, forKey key: String)
    
    func encodeValue(intv: Int8?, forKey key: String)
    func encodeValue(intv: Int16?, forKey key: String)
    func encodeValue(intv: Int32?, forKey key: String)
    func encodeValue(intv: Int64?, forKey key: String)
    func encodeValue(intv: Int?, forKey key:String)
    
    func encodeValue(intv: UInt8?, forKey key: String)
    func encodeValue(intv: UInt16?, forKey key: String)
    func encodeValue(intv: UInt32?, forKey key: String)
    func encodeValue(intv: UInt64?, forKey key: String)
    func encodeValue(intv: UInt?, forKey key:String)
    
    func encodeValue(realv: Float?, forKey key: String)
    func encodeValue(realv: Double?, forKey key: String)
    
    func encodeValue(strv: String?, forKey key: String)
    

    
    func decodeObjectForKey(key: String) -> AnyObject?
    func decodeDataForKey(key: String) -> NSData
    
    func decodeValueForKey(key: String) -> Bool?
    
    func decodeValueForKey(key: String) -> Int8?
    func decodeValueForKey(key: String) -> Int16?
    func decodeValueForKey(key: String) -> Int32?
    func decodeValueForKey(key: String) -> Int64?
    func decodeValueForKey(key: String) -> Int?
    
    func decodeValueForKey(key: String) -> UInt8?
    func decodeValueForKey(key: String) -> UInt16?
    func decodeValueForKey(key: String) -> UInt32?
    func decodeValueForKey(key: String) -> UInt64?
    func decodeValueForKey(key: String) -> UInt?
    
    func decodeValueForKey(key: String) -> Float?
    func decodeValueForKey(key: String) -> Double?
    
    
    func decodeValueForKey(key: String) -> String?
    
    func containsValueForKey(key: String) -> Bool
    
    /**
    func encodeBool(boolv: Bool, forKey key: String)
    
    func encodeInt8(intv: Int8?, forKey key: String)
    func encodeInt16(intv: Int16?, forKey key: String)
    func encodeInt32(intv: Int32?, forKey key: String)
    func encodeInt64(intv: Int64?, forKey key: String)
    func encodeUInt8(intv: UInt8?, forKey key: String)
    func encodeUInt16(intv: UInt16?, forKey key: String)
    func encodeUInt32(intv: UInt32?, forKey key: String)
    func encodeUInt64(intv: UInt64?, forKey key: String)
    
    func encodeFloat(realv: Float?, forKey key: String)
    func encodeDouble(realv: Double?, forKey key: String)
    
    func encodeString(strv: String?, forKey key: String)
    */

    /**
    func decodeBoolForKey(key: String) -> Bool?
    
    func decodeInt8ForKey(key: String) -> Int8?
    func decodeInt16ForKey(key: String) -> Int16?
    func decodeInt32ForKey(key: String) -> Int32?
    func decodeInt64ForKey(key: String) -> Int64?
    
    func decodeUInt8ForKey(key: String) -> UInt8?
    func decodeUInt16ForKey(key: String) -> UInt16?
    func decodeUInt32ForKey(key: String) -> UInt32?
    func decodeUInt64ForKey(key: String) -> UInt64?
    
    func decodeFloatForKey(key: String) -> Float?
    func decodeDoubleForKey(key: String) -> Double?


    func decodeStringForKey(key: String) -> String?
    */
    
}

public enum FC2Type : UInt8 {
    case FCTypeNil = 0
    case FCTypeObjectAlias8
    case FCTypeObjectAlias16
    case FCTypeObjectAlias32
    case FCTypeStringAlias8
    case FCTypeStringAlias16
    case FCTypeStringAlias32
    case FCTypeString
    case FCTypeDictionary
    case FCTypeArray
    case FCTypeSet
    case True
    case False
    case Int8
    case Int16
    case Int32
    case Int64
    case Float32
    case Float64
    case UInt8
    case UInt16
    case UInt32
    case UInt64
    case CodingObject
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

public class FastCoder2 { //<T : FCoding>

    // write data
    /**
    public static func dataWithRootObject(object : AnyObject) -> NSData? {
        
        let output : NSMutableData! = NSMutableData(length: 0) // TODO: define default size
        
        //create coder
        var coder = FC2Encoder(output)
        
        //write object
        coder.writeObject(object)
        
        return output
        
    }
    
    // read data
    public static func objectWithData(data: NSData) -> AnyObject? {
    
    var decoder = FC2Decoder(data)
    
    return nil // decoder.readObject(data)
    }
    */
    
    // write data
    public static func encodeRootElement<T: Encode>(element : T) -> NSData? {
        
        let output = NSMutableData()
        
        let coder = FC2Encoder(output)
        
        //coder.encode(element)
        element.encode(coder)

        return output
    }
    
    public static func decodeRootElement<T>(data : NSData) -> T? {
        
        let coder = FC2Decoder(data)
        
        return coder.read()
    }


    
}

public protocol Encode {
     func encode(coder : FC2Encoder)
}

extension Encode {
    public func encode(coder : FC2Encoder) {
        coder.encode(self)
    }
}

extension Bool : Encode{}

extension Int : Encode {}

extension UInt : Encode {}

extension UInt8 : Encode {}

extension Float : Encode {}

extension Double : Encode {}

/**

extension IntegerType {
    public func encode(coder : FC2Encoder) {
        coder.encode(self)
    }
}

*/



public class FC2Encoder : FC2Coder {
    
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
    
    var encodeOutput : NSMutableData
    
    init(_ data: NSMutableData) {
        encodeOutput = data
    }
    
    // MARK: encode methodes
    

    
    func encode(element: Coding) {
        writeType(.CodingObject)
        element.encodeWithCoder(self)
        writeType(.End)
    }
    
    func encode(obj: NSCoding) {
        
    }
    
    func encode(boolv : Bool) {
        if boolv {
            writeType(.True)
        } else {
            writeType(.False)
        }
    }
    
    func encode(intv : UInt8) {
        //direct encodeing -> no cache
        writeType(.UInt8)
        writeValue(intv)
    }
    
    func encode(intv: UInt16) {
        //direct encodeing -> no cache
        writeType(.UInt16)
        writeValue(intv)
    }
    
    func encode(intv: UInt32) {
        //direct encodeing -> no cache
        writeType(.UInt32)
        writeValue(intv)
    }
    
    func encode(intv : UInt64) {
        //direct encodeing -> no cache
        writeType(.UInt64)
        writeValue(intv)
    }
    
    func encode(intv : Int8) {
        //direct encodeing -> no cache
        writeType(.Int8)
        writeValue(intv)
    }
    
    func encode(intv: Int16) {
        //direct encodeing -> no cache
        writeType(.Int16)
        writeValue(intv)
    }
    
    func encode(intv: Int32) {
        //direct encodeing -> no cache
        writeType(.Int32)
        writeValue(intv)
    }
    
    func encode(intv : Int64) {
        //direct encodeing -> no cache
        writeType(.Int64)
        writeValue(intv)
    }
    
    func encode(realv : Float) {
        //direct encodeing -> no cache
        writeType(.Float32)
        writeValue(realv)
    }
    
    func encode(realv : Double) {
        //direct encodeing -> no cache
        writeType(.Float32)
        writeValue(realv)
    }
    
    func encode(intv : UInt) {
        //direct encodeing -> no cache
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
    
    func encode(intv : Int) {
        //direct encodeing -> no cache
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
    
    func encode(element : Any) {
        
        assertionFailure("Unsupported Root Element")
        /**
        switch element {
        //case let obj as NSCoding:
        //    print("NSCoding support")
        default:
            
        }
        */
    }
    
    // MARK: WriteMethodes
    
    func writeValue<T>(value : T) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(T))
    }
    
    func writeType(type : FC2Type) {
        writeValue(type.rawValue)
    }
    
    /**
    
    func writeUInt(value: UInt8) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(UInt8))
    }
    
    func writeUInt(value: UInt16) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(UInt16))
    }
    
    func writeUInt(value: UInt32) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(UInt32))
    }
    
    func writeUInt(value: UInt64) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(UInt64))
    }
    
    func writeInt(value: Int8) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(Int8))
    }
    
    func writeInt(value: Int16) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(Int16))
    }
    
    func writeInt(value: Int32) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(Int32))
    }
    
    func writeInt(value: Int64) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(Int64))
    }
    
    func writeFloat(value : Float32) {
        
        var data = value
        encodeOutput.appendBytes(&data, length:sizeof(Int64))
        
    }
    */
    
    // MARK: Protocol
    
        
    func encodeData(data: NSData, forKey key: String) {
        
    }
}

class FC2Decoder : FC2Coder {
    
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
    
    init(_ data: NSData) {
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
    
    // MARK: READ
    
    func read<T>() -> T? {
        
        let type = readType()
        
        return readInstance(type) as? T
        
    }
    
    func readInstance(type: FC2Type) -> Any? {
        
        switch type {
        case .FCTypeNil:
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
        case .FCTypeString:
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
    
    func readUInt8() -> Int {
        var value : UInt8 = 0
        readValue(&value)
        
        return Int(value)
    }
    
    func readUInt16() -> Int {
        
        var value : UInt16 = 0
        readValue(&value)
        
        return Int(value)
    }
    
    func readUInt32() -> Int {
        
        var value : UInt32 = 0
        readValue(&value)
        
        return Int(value)
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
    
    func readInt8() -> Int {
        var value : Int8 = 0
        readValue(&value)
        
        return Int(value)
        
    }
    
    func readInt16() -> Int {
        var value : Int16 = 0
        readValue(&value)
        
        return Int(value)
    }
    
    func readInt32() -> Int {
        var value : Int32 = 0
        readValue(&value)
        
        return Int(value)
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

    override func decodeObjectForKey(key: String) -> AnyObject? {
        return nil
    }
    
    override func decodeDataForKey(key: String) -> NSData {
        return NSMutableData()
    }
    
    override func containsValueForKey(key: String) -> Bool {
        return false
    }
    
}


// Abstract super class which implemet the FCoder protocol
public class FC2Coder : FCoder {
    // MARK: Protocol
    
    
    
    public func encodeObject(objv: AnyObject?, forKey key: String) {
        
    }
    
    public func encodeObject(data: NSData, forKey key: String) {
        
    }
    
    /**
    public func encodeValue<V>(value: V?, forKey key: String) {
        
    }
    */

    public func encodeValue(boolv: Bool?, forKey key: String) {
        
    }

    public func encodeValue(intv: Int8?, forKey key: String) {
        
    }

    public func encodeValue(intv: Int16?, forKey key: String) {
        
    }

    public func encodeValue(intv: Int32?, forKey key: String) {
        
    }

    public func encodeValue(intv: Int64?, forKey key: String) {
        
    }
    
    public func encodeValue(intv: Int?, forKey key: String) {
        
    }

    public func encodeValue(intv: UInt8?, forKey key: String) {
        
    }

    public func encodeValue(intv: UInt16?, forKey key: String) {
        
    }

    public func encodeValue(intv: UInt32?, forKey key: String) {
        
    }

    public func encodeValue(intv: UInt64?, forKey key: String) {
        
    }
    
    public func encodeValue(intv: UInt?, forKey key: String) {
        
    }
    
    public func encodeValue(realv: Float?, forKey key: String) {
        
    }

    public func encodeValue(realv: Double?, forKey key: String) {
        
    }
    
    public func encodeValue(strv: String?, forKey key: String) {
        
    }

    
    
    /**
    func encodeObject(objv: AnyObject?, forKey key: String) {
        
    }
    
    func encodeBool(boolv: Bool, forKey key: String) {
        
    }
    
    func encodeInt8(intv: Int8?, forKey key: String) {
        
    }
    
    func encodeInt16(intv: Int16?, forKey key: String) {
        
    }
    
    func encodeInt32(intv: Int32?, forKey key: String) {
        
    }
    
    func encodeInt64(intv: Int64?, forKey key: String) {
        
    }
    
    func encodeUInt8(intv: UInt8?, forKey key: String) {
        
    }
    
    func encodeUInt16(intv: UInt16?, forKey key: String) {
        
    }
    
    func encodeUInt32(intv: UInt32?, forKey key: String) {
        
    }
    
    func encodeUInt64(intv: UInt64?, forKey key: String) {
        
    }
    
    func encodeFloat(realv: Float?, forKey key: String) {
        
    }
    
    func encodeDouble(realv: Double?, forKey key: String) {
        
    }
    
    func encodeString(strv: String?, forKey key: String) {
        
    }
    
    func encodeData(data: NSData, forKey key: String) {
        
    }
    */
    
    // MARK: -------------
    
    
    public func decodeObjectForKey(key: String) -> AnyObject? {
        return nil
    }
    
    public func decodeDataForKey(key: String) -> NSData {
        return NSMutableData()
    }
    
    public func decodeValueForKey(key: String) -> Bool? {
        return nil
    }

    public func decodeValueForKey(key: String) -> Int8? {
        return nil
    }

    
    public func decodeValueForKey(key: String) -> Int16? {
        return nil
    }

    public func decodeValueForKey(key: String) -> Int32? {
        return nil
    }

    public func decodeValueForKey(key: String) -> Int64? {
        return nil
    }

    public func decodeValueForKey(key: String) -> Int? {
        return nil
    }
    
    public func decodeValueForKey(key: String) -> UInt8? {
        return nil
    }

    public func decodeValueForKey(key: String) -> UInt16? {
        return nil
    }

    public func decodeValueForKey(key: String) -> UInt32? {
        return nil
    }

    public func decodeValueForKey(key: String) -> UInt64? {
        return nil
    }
    
    public func decodeValueForKey(key: String) -> UInt? {
        return nil
    }

    public func decodeValueForKey(key: String) -> Float? {
        return nil
    }

    public func decodeValueForKey(key: String) -> Double? {
        return nil
    }

    public func decodeValueForKey(key: String) -> String? {
        return nil
    }

    /**
    
    func decodeObjectForKey(key: String) -> AnyObject? {
        return nil
    }
    
    func decodeBoolForKey(key: String) -> Bool? {
        return nil
    }
    
    
    func decodeInt8ForKey(key: String) -> Int8? {
        return nil
    }
    
    func decodeInt16ForKey(key: String) -> Int16? {
        return nil
    }
    
    func decodeInt32ForKey(key: String) -> Int32? {
        return nil
    }
    
    func decodeInt64ForKey(key: String) -> Int64? {
        return nil
    }
    
    func decodeUInt8ForKey(key: String) -> UInt8? {
        return nil
    }
    
    func decodeUInt16ForKey(key: String) -> UInt16? {
        return nil
    }
    
    func decodeUInt32ForKey(key: String) -> UInt32? {
        return nil
    }
    
    func decodeUInt64ForKey(key: String) -> UInt64? {
        return nil
    }
    
    func decodeFloatForKey(key: String) -> Float? {
        return nil
    }
    
    func decodeDoubleForKey(key: String) -> Double? {
        return nil
    }
    
    func decodeStringForKey(key: String) -> String? {
        return nil
    }
    
    func decodeDataForKey(key: String) -> NSData {
        return NSMutableData()
    }

    */
    
    public func containsValueForKey(key: String) -> Bool {
        return false
    }
}


