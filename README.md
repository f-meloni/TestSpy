# TestSpy

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-blue.svg)
[![Build Status](https://www.bitrise.io/app/17161483bf6ebfbb/status.svg?token=IUjjwJMbY1Z0bf_b24e_Vg&branch=master)](https://www.bitrise.io/app/17161483bf6ebfbb)

Swift Framework for Spy Objects

## Requirements
- Swift: 4.0
- iOS: 9+

## Create a spy object
To create a spy object you just have to implement the TestSpy protocol on your test class.

```swift
class TestClass: TestSpy {
     enum Method: Equatable {
         case test
         case testWithArgument(arument: Int)
     }
     
     var callstack = CallstackContainer<Method>()
}
```

Then when the method you want to test is called you have to record the method in the callstack

```swift
extension TestClass: TestProtocol {
    func test() {
        callstack.record(.test)
    }
    
    func testWithArgument(argument: Int) {
        callstack.record(.testWithArgument(argument: argument))
    }
}
```

## Use the spy object in tests

``` swift
XCTAssertTrue(spyObject.check(method: .test, predicate: .before(testWithArgument(argument:1))))
```

## Use the spy object in tests with Nimble

```swift
expect(spyObject).to(haveRecived(.test))
expect(spyObject).to(haveReceived(.test), before(testWithArgument(argument:1)))
```

## Author

Franco Meloni, franco.meloni91@gmail.com

## License

TestSpy is available under the MIT license. See the LICENSE file for more info.
