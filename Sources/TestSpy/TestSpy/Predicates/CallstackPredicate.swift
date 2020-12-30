//
//  CallstackPredicate.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

public protocol CallstackPredicate {
    associatedtype Method: Equatable
    
    func check(against callstack: [Method]) -> Bool
    func verify(method: Method) -> Bool
    func description(forMethod method: Method) -> String
}
struct AnyCallstcakPredicate<Method: Equatable>: CallstackPredicate {
    let  _check: ([Method]) -> Bool
    
    let  _verify:(Method) -> Bool
    let  _description:(Method) -> String
    
    init<P: CallstackPredicate>(predicate: P) where P.Method == Method {
        self._check = predicate.check(against: )
        self._verify = predicate.verify(method: )
        self._description = predicate.description(forMethod:)
    }
    func check(against callstack: [Method]) -> Bool {
        _check(callstack)
    }
    
    func verify(method: Method) -> Bool {
        _verify(method)
    }
    
    func description(forMethod method: Method) -> String {
        _description(method)
    }
    
    
}
