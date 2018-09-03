import XCTest

import TestSpyTests

var tests = [XCTestCaseEntry]()
tests += TestSpyTests.allTests()
XCTMain(tests)