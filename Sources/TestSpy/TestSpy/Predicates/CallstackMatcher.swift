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

    public func predicate(for method: Method) -> AnyCallstackPredicate<Method> {
        switch self {
        case let .times(times):
            return AnyCallstackPredicate(predicate: CallstackPredicates.TimesMatcher(method: method, times: times)
            )
        case let .atLeast(times: times):
            return AnyCallstackPredicate(predicate: CallstackPredicates.AtLeastMatcher(method: method, times: times)
            )
        case .never:
            return AnyCallstackPredicate(predicate: CallstackPredicates.NeverMatcher(expected: method)
            )
        case .any:
            return AnyCallstackPredicate(predicate: CallstackPredicates.AnyMatcher(method: method)
            )
        case .only:
            return AnyCallstackPredicate(predicate: CallstackPredicates.OnlyMatcher(method: method)
            )
        case let .before(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackPredicates.BeforeMatcher(method: method, otherMethod: otherMethod)
            )
        case let .immediatelyBefore(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackPredicates.ImmediatelyBeforeMatcher(method: method, otherMethod: otherMethod)
            )
        case let .after(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackPredicates.AfterMatcher(method: method, otherMethod: otherMethod)
            )
        case let .immediatelyAfter(otherMethod):
            return AnyCallstackPredicate(predicate: CallstackPredicates.ImmediatelyAfterMatcher(method: method, otherMethod: otherMethod)
            )
        }
    }
}
