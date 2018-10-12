import XCTest

#if !os(macOS) && !os(iOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TestSpyTests.allTests),
    ]
}
#endif
