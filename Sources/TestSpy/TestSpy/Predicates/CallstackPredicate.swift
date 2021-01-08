//
//  CallstackPredicate.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

public protocol CallstackPredicate {
    associatedtype Method: Equatable
    
    /// [TestSpy] checking the callstack has the expected behavior
    /// - Parameter callstack: Methods provide by TestSpy framework
    /// - Returns: true for assert correct, false for assert incorrect
    /// - SeeAlso: description(forMethod:)
    func check(against callstack: [Method]) -> Bool
    func description(forMethod method: Method) -> String
}
