//
//  CallstackMatcher.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

public enum CallstackMatcher<Method: Equatable> {
    case times(Int)
    case atLeast(times: Int)
    case never
    case any
    case only
    case before(Method)
    case immediatelyBefore(Method)
    case after(Method)
    case immediatelyAfter(Method)
    
    func predicate(method: Method) -> AnyCallstcakPredicate<Method>{
        switch self {
            case let .times(times):
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.TimesMatcher(method: method, times: times)
                )
            case .atLeast(times: let times):
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.AtLeastMatcher(method: method, times: times)
                )
            case .never:
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.NeverMatcher(expected: method)
                )
            case .any:
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.AnyMatcher(method: method)
                )
            case .only:
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.OnlyMatcher(method: method)
                )
            case let .before(otherMethod):
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.BeforeMatcher(method: method, otherMethod: otherMethod)
                )
            case let .immediatelyBefore(otherMethod):
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.ImmediatelyBeforeMatcher(method: method, otherMethod: otherMethod)
                )
            case let .after(otherMethod):
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.AfterMatcher(method: method, otherMethod: otherMethod)
                )
            case let .immediatelyAfter(otherMethod):
                return AnyCallstcakPredicate(predicate:
                                              CallstackMatchers.ImmediatelyAfterMatcher(method: method, otherMethod: otherMethod)
                )
        }
    }
}
