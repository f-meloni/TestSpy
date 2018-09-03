//
//  CallstackMatchers+NimbleSpec.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import Quick
import Nimble
@testable import TestSpy

class CallstackMatchers_NimbleSpec: QuickSpec {
    override func spec() {
        var testSpy: TestSpyObject!
        
        describe("Given an object that is implementing the TestSpy protocol") {
            beforeEach {
                testSpy = TestSpyObject()
            }
            
            context("When the haveReceived matcher is called with 'any'") {
                it("Matches if the method is contained in the callstack") {
                    testSpy.callstack.callstack = [.method1]
                    expect(testSpy).to(haveReceived(.method1, .any))
                }
                
                it("Doesn't match false if the method is not contained in the callstack") {
                    expect(testSpy).toNot(haveReceived(.method1, .any))
                }
            }
            
            context("When the haveReceived matcher is called with 'never'") {
                it("Matches false if the method is not contained in the callstack") {
                    expect(testSpy).to(haveReceived(.method1, .never))
                }
                
                it("Doesn't match if the method is contained in the callstack") {
                    testSpy.callstack.callstack = [.method1]
                    expect(testSpy).toNot(haveReceived(.method1, .never))
                }
            }
            
            context("When the haveReceived matcher is called with 'times(2)'") {
                it("Doesn't match if the method is contained just one time in the callstack") {
                    testSpy.callstack.callstack = [.method1, .method2]
                    expect(testSpy).toNot(haveReceived(.method1, .times(2)))
                }
                
                it("Doesn't match if the method is not contained in the callstack") {
                    testSpy.callstack.callstack = [.method2]
                    expect(testSpy).toNot(haveReceived(.method1, .times(2)))
                }
                
                it("Matches if the method is contained two times in the callstack") {
                    testSpy.callstack.callstack = [.method1, .method1]
                    expect(testSpy).to(haveReceived(.method1, .times(2)))
                }
                
                it("Doesn't match if the method is contained more two times in the callstack") {
                    testSpy.callstack.callstack = [.method1, .method1, .method1]
                    expect(testSpy).toNot(haveReceived(.method1, .times(2)))
                }
            }
            
            context("When the haveReceived matcher is called with 'atLeast(times: 2)'") {
                it("Doesn't match if the method is contained just one time in the callstack") {
                    testSpy.callstack.callstack = [.method1, .method2]
                    expect(testSpy).toNot(haveReceived(.method1, .atLeast(times: 2)))
                }
                
                it("Doesn't match if the method is not contained in the callstack") {
                    testSpy.callstack.callstack = [.method2]
                    expect(testSpy).toNot(haveReceived(.method1, .atLeast(times: 2)))
                }
                
                it("Matches if the method is contained two times in the callstack") {
                    testSpy.callstack.callstack = [.method1, .method1]
                    expect(testSpy).to(haveReceived(.method1, .atLeast(times: 2)))
                }
                
                it("Matches if the method is contained more two times in the callstack") {
                    testSpy.callstack.callstack = [.method1, .method1, .method1]
                    expect(testSpy).to(haveReceived(.method1, .atLeast(times: 2)))
                }
            }
            
            context("When the haveReceived matcher is called with 'before(method)'") {
                it("Doesn't match if the method is not contained in the callstack") {
                    testSpy.callstack.callstack = [.method2]
                    expect(testSpy).toNot(haveReceived(.method1, .before(.method2)))
                }
                
                it("Matches if the method is contained and is before the other method") {
                    testSpy.callstack.callstack = [.method1, .method2]
                    expect(testSpy).to(haveReceived(.method1, .before(.method2)))
                }
                
                it("Doesn't match if the method is contained but is not before the other method") {
                    testSpy.callstack.callstack = [.method2, .method1]
                    expect(testSpy).toNot(haveReceived(.method1, .before(.method2)))
                }
            }
            
            context("When the haveReceived matcher is called with 'immediatelyBefore(method)'") {
                it("Doesn't match if the method is not contained in the callstack") {
                    testSpy.callstack.callstack = [.method2]
                    expect(testSpy).toNot(haveReceived(.method1, .immediatelyBefore(.method2)))
                }
                
                it("Matches if the method is contained and is immediately before the other method") {
                    testSpy.callstack.callstack = [.method1, .method2]
                    expect(testSpy).to(haveReceived(.method1, .immediatelyBefore(.method2)))
                }
                
                it("Doesn't match if the method is contained and before but not immediately before the other method") {
                    testSpy.callstack.callstack = [.method1, .method3, .method2]
                    expect(testSpy).toNot(haveReceived(.method1, .immediatelyBefore(.method2)))
                }
                
                it("Doesn't match if the method is contained but is not immediately before the other method") {
                    testSpy.callstack.callstack = [.method2, .method1]
                    expect(testSpy).toNot(haveReceived(.method1, .immediatelyBefore(.method2)))
                }
            }
            
            context("When the haveReceived matcher is called with 'after(method)'") {
                it("Doesn't match if the method is not contained in the callstack") {
                    testSpy.callstack.callstack = [.method1]
                    expect(testSpy).toNot(haveReceived(.method2, .after(.method1)))
                }
                
                it("Matches if the method is contained and is after the other method") {
                    testSpy.callstack.callstack = [.method1, .method2]
                    expect(testSpy).to(haveReceived(.method2, .after(.method1)))
                }
                
                it("Doesn't match if the method is contained but is not after the other method") {
                    testSpy.callstack.callstack = [.method2, .method1]
                    expect(testSpy).toNot(haveReceived(.method2, .after(.method1)))
                }
            }
            
            context("When the haveReceived matcher is called with 'immediatelyAfter(method)'") {
                it("Doesn't match if the method is not contained in the callstack") {
                    testSpy.callstack.callstack = [.method1]
                    expect(testSpy).toNot(haveReceived(.method2, .immediatelyAfter(.method1)))
                }
                
                it("Matches if the method is contained and is immediately after the other method") {
                    testSpy.callstack.callstack = [.method1, .method2]
                    expect(testSpy).to(haveReceived(.method2, .immediatelyAfter(.method1)))
                }
                
                it("Doesn't match if the method is contained and before but not immediately before the other method") {
                    testSpy.callstack.callstack = [.method1, .method3, .method2]
                    expect(testSpy).toNot(haveReceived(.method2, .immediatelyAfter(.method1)))
                }
                
                it("Doesn't match if the method is contained but is not immediately after the other method") {
                    testSpy.callstack.callstack = [.method2, .method1]
                    expect(testSpy).toNot(haveReceived(.method2, .immediatelyAfter(.method1)))
                }
            }
        }
    }
}
