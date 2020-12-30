//
//  CallstackMatcher.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

public enum CallstackMatcher<T: Equatable>: CallstackPredicate {
    case times(Int)
    case atLeast(times: Int)
    case never
    case any
    case only
    case before(T)
    case immediatelyBefore(T)
    case after(T)
    case immediatelyAfter(T)
    
    public func verify(method: T, expected: T) -> Bool {
        switch self {
        case .times:
            return expected ==  method
        case .atLeast:
            return expected == method
        case .never:
            return expected !=  method
        case .any:
            return expected ==  method
        case .only:
            return expected ==  method
        case .before:
            return expected ==  method
        case .immediatelyBefore:
            return expected ==  method
        case .after:
            return expected ==  method
        case .immediatelyAfter:
            return expected ==  method
        }
    }
    public func check(method: T, against callstack: [T]) -> Bool {
        switch self {
        case .times(let times):
            return callstack.filter {self.verify(method: $0, expected: method)}.count == times
        case .atLeast(let times):
            return callstack.filter {self.verify(method: $0, expected: method)}.count >= times
        case .never:
            return callstack.allSatisfy{self.verify(method: $0, expected: method)}
        case .any:
            return callstack.contains{self.verify(method: $0, expected: method)}
        case .only:
            return callstack == [method]
        case .before(let otherMethod):
            return check(method: method, isBefore: otherMethod, onCallstack: callstack)
        case .immediatelyBefore(let otherMethod):
            return check(method: method, isImmediatelyBefore: otherMethod, onCallstack: callstack)
        case .after(let otherMethod):
            return check(method: method, isAfter: otherMethod, onCallstack: callstack)
        case .immediatelyAfter(let otherMethod):
            return check(method: method, isImmediatelyAfter: otherMethod, onCallstack: callstack)
        }
    }
    
    public func description(forMethod method: T) -> String {
        switch self {
        case .times(let times):
            return "have received \(method) \(times) times"
        case .atLeast(let times):
            return "have received \(method) at least \(times) times"
        case .never:
            return "have not received \(method)"
        case .any:
            return "have received \(method)"
        case .only:
            return "have received only \(method)"
        case .before(let otherMethod):
            return "have received \(method) before \(otherMethod)"
        case .immediatelyBefore(let otherMethod):
            return "have received \(method) immediately before \(otherMethod)"
        case .after(let otherMethod):
            return "have received \(method) after \(otherMethod)"
        case .immediatelyAfter(let otherMethod):
            return "have received \(method) immediately after \(otherMethod)"
        }
    }
}

private extension CallstackMatcher {
    private func check(method: T, isBefore otherMethod: T, onCallstack callstack: [T]) -> Bool {
        guard let methodIndex = callstack.firstIndex(where: {self.verify(method: $0, expected: method)}),
            let otherMethodIndex = callstack.firstIndex(of: otherMethod) else {
                return false
        }
        
        return methodIndex < otherMethodIndex
    }
    
    private func check(method: T, isImmediatelyBefore otherMethod: T, onCallstack callstack: [T]) -> Bool {
        guard let methodIndex = callstack.firstIndex(where: {self.verify(method: $0, expected: method)}),
            let otherMethodIndex = callstack.firstIndex(of: otherMethod) else {
                return false
        }
        
        return methodIndex == otherMethodIndex - 1
    }
    
    private func check(method: T, isAfter otherMethod: T, onCallstack callstack: [T]) -> Bool {
        guard let methodIndex = callstack.firstIndex(where: {self.verify(method: $0, expected: method)}),
            let otherMethodIndex = callstack.firstIndex(of: otherMethod) else {
                return false
        }
        
        return methodIndex > otherMethodIndex
    }
    
    private func check(method: T, isImmediatelyAfter otherMethod: T, onCallstack callstack: [T]) -> Bool {
        guard let methodIndex = callstack.firstIndex(where: {self.verify(method: $0, expected: method)}),
            let otherMethodIndex = callstack.firstIndex(of: otherMethod) else {
                return false
        }
        
        return methodIndex == otherMethodIndex + 1
    }
}

