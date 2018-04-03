//
//  TestSpy+Matchers.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import Nimble

public func haveReceived<Spy: TestSpy>(_ method: Spy.Method, _ matcher: CallstackMatcher<Spy.Method> = .any) -> Predicate<Spy> {
    return satisfyPredicateCheck(matcher, method: method)
}

public func beEmpty<Spy: TestSpy>() -> Predicate<Spy> {
    return Predicate { actual -> PredicateResult in
        let expectationMessage = "have received an empty callstack"
        
        guard let spy = try actual.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedActualValueTo(
                expectationMessage).appendedBeNilHint()
            )
        }

        return PredicateResult(bool: spy.callstack.isEmpty, message: ExpectationMessage.expectedTo(
            "\(expectationMessage), but only received: \(spy.callstack)")
        )
    }
    
}

public func satisfyPredicateCheck<Spy: TestSpy, P: CallstackPredicate>(_ predicate: P, method: Spy.Method) -> Predicate<Spy> where P.Method == Spy.Method {
    return Predicate { actual -> PredicateResult in
        let expectationMessage = String(format: expectationFormattableMessage(forPredicate: predicate), method as! CVarArg)

        guard let spy = try actual.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedActualValueTo(
                expectationMessage).appendedBeNilHint()
            )
        }
        return PredicateResult(bool: spy.check(method: method, predicate: predicate), message: ExpectationMessage.expectedTo(
            "\(expectationMessage), but only received: \(spy.callstack)")
        )
    }
}


private func expectationFormattableMessage<P: CallstackPredicate>(forPredicate predicate: P) -> String {
    guard let predicate = predicate as? FormattablePredicate else {
        return "satisfy the predicate check"
    }
    
    return predicate.formattablePredicateMessage
}
