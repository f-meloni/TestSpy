//
//  TestSpySpec.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import Quick
import Nimble
@testable import TestSpy

final class TestSpySpec: QuickSpec {
    override func spec() {
        var testSpy: TestSpyObject!
        
        describe("Given an object that is implementing the TestSpy protocol") {
            beforeEach {
                testSpy = TestSpyObject()
            }
            
            context("When the check method is called") {
                var stubbedPredicate: FakeCallstackPredicate!
                
                beforeEach {
                    stubbedPredicate = FakeCallstackPredicate()
                }
                
                it("Calls the predicate with the correct parameters") {
                    testSpy.callstack.record(.method2)
                    _ = testSpy.check(method: .method1, predicate: stubbedPredicate)
                    
                    expect(stubbedPredicate.receivedMethod) == .method1
                    expect(stubbedPredicate.receivedCallstack) == testSpy.callstack.callstack
                }
                
                it("Returns true if the check is satisfied") {
                    stubbedPredicate.stubbedResponse = true
                    expect(testSpy.check(method: .method1, predicate: stubbedPredicate)) == true
                }
                
                it("Returns false if the check is not satisfied") {
                    stubbedPredicate.stubbedResponse = false
                    expect(testSpy.check(method: .method1, predicate: stubbedPredicate)) == false
                }
            }
        }
    }
}



