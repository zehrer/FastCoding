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

public protocol FCoding {
    
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
    case FCTypeTrue
    case FCTypeFalse
    case FCTypeInt8
    case FCTypeInt16
    case FCTypeInt32
    case FCTypeInt64
    case FCTypeFloat32
    case FCTypeFloat64
    case FCTypeObject
    case FCTypeData
    case FCTypeDate
    case FCTypeMutableData
    case FCTypeDecimalNumber
    case FCTypeOne
    case FCTypeZero
    case FCTypeEnd
    
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
    public static func encodeRootElement(element : Any) -> NSData? {
        
        let output = NSMutableData()
        
        let coder = FC2Encoder(output)
        
        coder.encode(element)

        return output
    }
    
    public static func decodeRootElement<T :FCoding>(data : NSData) -> T? {
        
        let coder = FC2Decoder(data)
        
        return coder.read()
    }


    
}


class FC2Encoder : FC2Coder {
    
    // Key is a object, values are the related index
    var objectCache = Dictionary<NSObject,Index>()
    
    // Key is a string, value is the related index
    var stringCache = Dictionary<String,Index>()
    
    var encodeOutput : NSMutableData
    
    init(_ data: NSMutableData) {
        encodeOutput = data
    }
    
    // MARK:
    
    func encode(element : Any) {
        switch element {
        case let obj as NSCoder:
            print("NSCoder supprot")
        case let coding as FCoding:
            // TODO
            coding.encodeWithCoder(self)
        case let boolv as Bool:
            writeBool(boolv)
        case let intv as Int:
            writeInt(intv)
        default:
            assertionFailure("Unsupported Root Element")
        }
    }
    
    // MARK: WriteMethodes
    
    func writeType(type : FC2Type) {
        
    }
    
    func writeBool(boolv : Bool) {
        
    }
    
    func writeInt(intv : Int) {
        
    }

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
    
    func readObject<O : FCoding>() -> O {
        
        let className = readString()
        let oldProperties = properties
        
        properties = Dictionary()
        
        while (true) {
            // read all elements as input for initWithCoder:
            let type = readType()
            
            if type == .FCTypeEnd {
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
        case .FCTypeTrue:
            return true
        case .FCTypeFalse:
            return false
        case .FCTypeInt8:
            return readInt8()
        case .FCTypeInt16:
            return readInt16()
        case .FCTypeInt32:
            return readInt32()
        case .FCTypeInt64:
            return readInt64()
        case .FCTypeFloat32:
            return readFloat32()
        case .FCTypeFloat64:
            return readFloat64()  // Double
        //case .FCTypeObject:
        //    return readObject()
        //case FCTypeDate
        //case FCTypeData
        //case FCTypeMutableData
        //case FCTypeDecimalNumber
        case .FCTypeOne:
            return 1
        case .FCTypeZero:
            return 0
        case .FCTypeEnd:
            assertionFailure("Error: end type on the wrong place")
        case .FCTypeUnknown:
            assertionFailure("Error during encoding, unknown type found")
        default:
            assertionFailure("Not supported type")
            
        }
        
        return nil
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
class FC2Coder : FCoder {
    // MARK: Protocol
    
    func encodeObject(objv: AnyObject?, forKey key: String) {
        
    }
    
    func encodeObject(data: NSData, forKey key: String) {
        
    }

    func encodeValue(boolv: Bool?, forKey key: String) {
        
    }

    func encodeValue(intv: Int8?, forKey key: String) {
        
    }

    func encodeValue(intv: Int16?, forKey key: String) {
        
    }

    func encodeValue(intv: Int32?, forKey key: String) {
        
    }

    func encodeValue(intv: Int64?, forKey key: String) {
        
    }
    
    func encodeValue(intv: Int?, forKey key: String) {
        
    }

    func encodeValue(intv: UInt8?, forKey key: String) {
        
    }

    func encodeValue(intv: UInt16?, forKey key: String) {
        
    }

    func encodeValue(intv: UInt32?, forKey key: String) {
        
    }

    func encodeValue(intv: UInt64?, forKey key: String) {
        
    }
    
    func encodeValue(intv: UInt?, forKey key: String) {
        
    }
    
    func encodeValue(realv: Float?, forKey key: String) {
        
    }

    func encodeValue(realv: Double?, forKey key: String) {
        
    }
    
    func encodeValue(strv: String?, forKey key: String) {
        
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
    
    
    func decodeObjectForKey(key: String) -> AnyObject? {
        return nil
    }
    
    func decodeDataForKey(key: String) -> NSData {
        return NSMutableData()
    }
    
    func decodeValueForKey(key: String) -> Bool? {
        return nil
    }

    func decodeValueForKey(key: String) -> Int8? {
        return nil
    }

    
    func decodeValueForKey(key: String) -> Int16? {
        return nil
    }

    func decodeValueForKey(key: String) -> Int32? {
        return nil
    }

    func decodeValueForKey(key: String) -> Int64? {
        return nil
    }

    func decodeValueForKey(key: String) -> Int? {
        return nil
    }
    
    func decodeValueForKey(key: String) -> UInt8? {
        return nil
    }

    func decodeValueForKey(key: String) -> UInt16? {
        return nil
    }

    func decodeValueForKey(key: String) -> UInt32? {
        return nil
    }

    func decodeValueForKey(key: String) -> UInt64? {
        return nil
    }
    
    func decodeValueForKey(key: String) -> UInt? {
        return nil
    }

    func decodeValueForKey(key: String) -> Float? {
        return nil
    }

    func decodeValueForKey(key: String) -> Double? {
        return nil
    }

    func decodeValueForKey(key: String) -> String? {
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
    
    func containsValueForKey(key: String) -> Bool {
        return false
    }
}


