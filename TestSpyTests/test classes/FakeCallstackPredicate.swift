//
//  FakeCallstackPredicate.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

@testable import TestSpy

final class FakeCallstackPredicate: CallstackPredicate {
    var stubbedResponse: Bool = true
    var receivedMethod: TestMethod?
    var receivedCallstack: [TestMethod]?
    
    func check(method: TestMethod, against callstack: [TestMethod]) -> Bool {
        receivedCallstack = callstack
        receivedMethod = method
        return stubbedResponse
    }
    
    func description(forMethod method: TestMethod) -> String {
        return "return \(stubbedResponse) for method \(method)"
    }
}
