//
//  TestSpy+MatchersSpec.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import Quick
import Nimble
@testable import TestSpy

class TestSpy_MatchersSpec: QuickSpec {
    override func spec() {
        var testSpy: TestSpyObject!
        
        describe("Given an object that is implementing the TestSpy protocol") {
            beforeEach {
                testSpy = TestSpyObject()
            }
            
            context("When the satisfyPredicateCheck matcher is used") {
                var stubbedPredicate: FakeCallstackPredicate!
                
                beforeEach {
                    stubbedPredicate = FakeCallstackPredicate()
                }
                

                it("Matches if the check is satisfied") {
                    stubbedPredicate.stubbedResponse = true
                    expect(testSpy).to(satisfyPredicateCheck(stubbedPredicate, method: .method1))
                }
                
                it("Doesn't match if the check is not satisfied") {
                    stubbedPredicate.stubbedResponse = false
                    expect(testSpy).toNot(satisfyPredicateCheck(stubbedPredicate, method: .method1))
                }
            }
            
            context("When the beEmpty matcher is used") {
                it("Matches if the callstack is empty") {
                    expect(testSpy).to(beEmpty())
                }
                
                it("Doesn't match if the check is not satisfied") {
                    testSpy.callstack.record(.method1)
                    expect(testSpy).toNot(beEmpty())
                }
            }
        }
    }
}
