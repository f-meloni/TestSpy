//
//  CallstackMatcherSpec.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import Quick
import Nimble
@testable import TestSpy

final class CallstackMatcherSpec: QuickSpec {
    override func spec() {
        var matcher: AnyCallstackPredicate<TestMethod>!
        
        describe("Given an 'any' matcher") {
            beforeEach {
                matcher = CallstackMatcher.any.predicate(method: .method1)
            }
            
            context("When the check is called") {
                it("Returns true if the method is contained in the callstack") {
                    expect(matcher.check(against: [.method1, .method2])) == true
                }
                
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method2])) == false
                }
            }
        }
        
        describe("Given a 'never' matcher") {
            beforeEach {
                matcher = CallstackMatcher.never.predicate(method: .method1)
            }
            
            context("When the check is called") {
                it("Returns false if the method is contained in the callstack") {
                    expect(matcher.check(against: [.method1, .method2])) == false
                }
                
                it("Returns true if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method2])) == true
                }
            }
        }
        
        describe("Given a 'times(2)' matcher") {
            beforeEach {
                matcher = CallstackMatcher.times(2).predicate(method: .method1)
            }
            
            context("When the check is called") {
                it("Returns false if the method is contained just one time in the callstack") {
                    expect(matcher.check(against: [.method1, .method2])) == false
                }
                
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method2])) == false
                }
                
                it("Returns true if the method is contained two times in the callstack") {
                    expect(matcher.check(against: [.method1, .method1])) == true
                }
                
                it("Returns false if the method is contained more two times in the callstack") {
                    expect(matcher.check(against: [.method1, .method1, .method1])) == false
                }
            }
        }
        
        describe("Given a 'atLeast(2)' matcher") {
            beforeEach {
                matcher = CallstackMatcher.atLeast(times: 2).predicate(method: .method1)
            }
            
            context("When the check is called") {
                it("Returns false if the method is contained just one time in the callstack") {
                    expect(matcher.check(against: [.method1, .method2])) == false
                }
                
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method2])) == false
                }
                
                it("Returns true if the method is contained two times in the callstack") {
                    expect(matcher.check(against: [.method1, .method1])) == true
                }
                
                it("Returns true if the method is contained more two times in the callstack") {
                    expect(matcher.check(against: [.method1, .method1, .method1])) == true
                }
            }
        }
        
        describe("Given a 'before(method)' matcher") {
            beforeEach {
                matcher = CallstackMatcher.before(.method2).predicate(method: .method1)
            }
            
            context("When the check is called") {
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method2])) == false
                }
                
                it("Returns true if the method is contained and is before the other method") {
                    expect(matcher.check(against: [.method1, .method2])) == true
                }
                
                it("Returns false if the method is contained but is not before the other method") {
                    expect(matcher.check(against: [.method2, .method1])) == false
                }
            }
        }
        
        describe("Given an 'immediatelyBefore(method)' matcher") {
            beforeEach {
                matcher = CallstackMatcher.immediatelyBefore(.method2).predicate(method: .method1)
            }
            
            context("When the check is called") {
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method2])) == false
                }
                
                it("Returns true if the method is contained and is immediately before the other method") {
                    expect(matcher.check(against: [.method1, .method2])) == true
                }
                
                it("Returns false if the method is contained and is before, but not immediately before the other method") {
                    expect(matcher.check(against: [.method1, .method3, .method2])) == false
                }
                
                it("Returns false if the method is contained but is not before the other method") {
                    expect(matcher.check(against: [.method2, .method1])) == false
                }
            }
        }
        
        describe("Given a 'after(method)' matcher") {
            beforeEach {
                matcher = CallstackMatcher.after(.method1).predicate(method: .method2)
            }
            
            context("When the check is called") {
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method1])) == false
                }
                
                it("Returns true if the method is contained and is after the other method") {
                    expect(matcher.check(against: [.method1, .method2])) == true
                }
                
                it("Returns false if the method is contained but is not after the other method") {
                    expect(matcher.check(against: [.method2, .method1])) == false
                }
            }
        }
        
        describe("Given a 'immediatelyAfter(method)' matcher") {
            beforeEach {
                matcher = CallstackMatcher.immediatelyAfter(.method1).predicate(method: .method2)
            }
            
            context("When the check is called") {
                it("Returns false if the method is not contained in the callstack") {
                    expect(matcher.check(against: [.method1])) == false
                }
                
                it("Returns true if the method is contained and is immediately after the other method") {
                    expect(matcher.check(against: [.method1, .method2])) == true
                }
                
                it("Returns false if the method is contained but is not immediately after the other method") {
                    expect(matcher.check(against: [.method2, .method3, .method1])) == false
                }
                
                it("Returns false if the method is contained but is not after the other method") {
                    expect(matcher.check(against: [.method2, .method1])) == false
                }
            }
        }
    }
}
