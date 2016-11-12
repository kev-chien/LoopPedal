import Foundation
extension NSData {
    
    static func dataWithValue<T>(value: T) -> NSData {
        var variableValue = value
        return NSData(bytes: &variableValue, length: MemoryLayout<T>.size)
    }
    
    func int8Value() -> Int8 {
        var value: Int8 = 0
        getBytes(&value, length: MemoryLayout<Int8>.size)
        return value
    }
    
}
