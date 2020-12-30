//
//  CallStackContainerSpec.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import Quick
import Nimble
@testable import TestSpy

final class CallStackContainerSpec: QuickSpec {
    override func spec() {
        var callstackContainer: CallstackContainer<TestMethod>!
        
        describe("Given a CallstackContainer") {
            beforeEach {
                callstackContainer = CallstackContainer()
            }
            
            context("When nothing is added to the callstack") {
                it("The isEmpty variable is true") {
                    expect(callstackContainer.isEmpty) == true
                }
            }
            
            context("When the record method is called") {
                beforeEach {
                    callstackContainer.record(.method1)
                }
                
                it("Records the method on the callstack") {
                    expect(callstackContainer.callstack) == [.method1]
                }
                
                it("The isEmpty variable is false") {
                    expect(callstackContainer.isEmpty) == false
                }
            }
            
            context("When the check method is called") {
                var stubbedPredicate: FakeCallstackPredicate!
                
                beforeEach {
                    stubbedPredicate = FakeCallstackPredicate()
                }
                
                it("Calls the predicate with the correct parameters") {
                    callstackContainer.record(.method2)
                    _ = callstackContainer.check(predicate: stubbedPredicate)
                    
                    expect(stubbedPredicate.receivedMethod) == nil
                    expect(stubbedPredicate.receivedCallstack) == callstackContainer.callstack
                }
                
                it("Returns true if the check is satisfied") {
                    stubbedPredicate.stubbedResponse = true
                    expect(callstackContainer.check(predicate: stubbedPredicate)) == true
                }
                
                it("Returns false if the check is not satisfied") {
                    stubbedPredicate.stubbedResponse = false
                    expect(callstackContainer.check(predicate: stubbedPredicate)) == false
                }
            }
            
            context("When is compared with an array") {
                beforeEach {
                    callstackContainer.record(.method2)
                    callstackContainer.record(.method3)
                }
                
                it("Returns true if they contain the same elements") {
                    let comparisonArray: [TestMethod] = [.method2, .method3]
                    expect(callstackContainer == comparisonArray) == true
                }
                
                it("Returns false if they don't contain the same elements") {
                    let comparisonArray: [TestMethod] = [.method1, .method2]
                    expect(callstackContainer == comparisonArray) == false
                }
            }
        }
    }
}
