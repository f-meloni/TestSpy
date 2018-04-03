//
//  CallstackPredicate.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

public protocol CallstackPredicate {
    associatedtype Method: Equatable
    
    func check(method: Method, against callstack: [Method]) -> Bool
}

public protocol FormattablePredicate {
    var formattablePredicateMessage: String { get }
}

