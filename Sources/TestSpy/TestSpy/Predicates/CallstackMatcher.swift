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

    func predicate(method: Method) -> AnyCallstackPredicate<Method> {
        switch self {
        case let .times(times):
            return AnyCallstackPredicate(predicate: CallstackMatchers.TimesMatcher(method: method, times: times)
            )
        case let .atLeast(times: times):
            return AnyCallstackPredicate(predicate: CallstackMatchers.AtLeastMatcher(method: method, times: times)
            )
        case .never:
            return AnyCallstackPredicate(predicate: CallstackMatchers.NeverMatcher(expected: method)
            )
        case .any:
            return AnyCallstackPredicate(predicate: CallstackMatchers.AnyMatcher(method: method)
            )
        case .only:
            return AnyCallstackPredicate(predicate: CallstackMatchers.OnlyMatcher(method: method)
            )
        case let .before(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackMatchers.BeforeMatcher(method: method, otherMethod: otherMethod)
            )
        case let .immediatelyBefore(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackMatchers.ImmediatelyBeforeMatcher(method: method, otherMethod: otherMethod)
            )
        case let .after(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackMatchers.AfterMatcher(method: method, otherMethod: otherMethod)
            )
        case let .immediatelyAfter(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackMatchers.ImmediatelyAfterMatcher(method: method, otherMethod: otherMethod)
            )
        }
    }
}
