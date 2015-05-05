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


protocol FCoding {
    
    //Only within the Initialization of an object it is possible 
    // to set the value of a stored property if it is not optional
    init(coder aDecoder: FCoder)
    
    
    func encodeWithCoder(aCoder: FCoder)
}

protocol FCoder {
    
    func encodeObject(objv: AnyObject?, forKey key: String)
    
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
    
    func encodeData(data: NSData, forKey key: String)
    
    func decodeObjectForKey(key: String) -> AnyObject?
    
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
    
    func decodeDataForKey(key: String) -> NSData
    
    func containsValueForKey(key: String) -> Bool

}

enum FC2Type : UInt8 {
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
    case FCTypeData
    case FCTypeDate
    case FCTypeMutableString
    case FCTypeMutableDictionary
    case FCTypeMutableArray
    case FCTypeMutableSet
    case FCTypeMutableOrderedSet
    case FCTypeMutableData
    case FCTypeClassDefinition
    case FCTypeObject8
    case FCTypeObject16
    case FCTypeObject32
    case FCTypeURL
    case FCTypePoint
    case FCTypeSize
    case FCTypeRect
    case FCTypeRange
    case FCTypeVector
    case FCTypeAffineTransform
    case FCType3DTransform
    case FCTypeMutableIndexSet
    case FCTypeIndexSet
    case FCTypeNSCodedObject
    case FCTypeDecimalNumber
    case FCTypeOne
    case FCTypeZero
    case FCTypeEnd  // mark a end (e.g. end of a list)
    
    case FCTypeUnknown // renamed FCTypeCount (entinel value)
}
