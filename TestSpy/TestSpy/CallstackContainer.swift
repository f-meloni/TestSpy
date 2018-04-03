//
//  CallstackContainer.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

public struct CallstackContainer<T: Equatable>: Equatable, CustomStringConvertible {
    var callstack: [T] = []
    
    var isEmpty: Bool {
        return callstack.isEmpty
    }
    
    public var description: String {
        return "[" + callstack.map { String(describing: $0) }.joined(separator: ", ") + "]"
    }
    
    public init() { }
    
    public mutating func record(_ method: T) {
        callstack.append(method)
    }
    
    func check<P: CallstackPredicate>(method: T, predicate: P) -> Bool where P.Method == T {
        return predicate.check(method: method, against: callstack)
    }
    
    public static func ==<T>(lhs: CallstackContainer<T>, rhs: CallstackContainer<T>) -> Bool {
        return lhs.callstack == rhs.callstack
    }
}

public func ==<T>(lhs: CallstackContainer<T>, rhs: [T]) -> Bool {
    return lhs.callstack == rhs
}
