# TestSpy

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-blue.svg)
[![Build Status](https://www.bitrise.io/app/17161483bf6ebfbb/status.svg?token=IUjjwJMbY1Z0bf_b24e_Vg&branch=master)](https://www.bitrise.io/app/17161483bf6ebfbb)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)

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
XCTAssertTrue(spyObject.check(method: .test, predicate: .any))
```

## Use the spy object in tests with Nimble

```swift
expect(spyObject).to(haveRecived(.test))
```

## Callstack Matchers

There are some default matchers that can be used on the test to check that callstack content.

The main matchers are:

- times(Int)
- atLeast(times: Int)
- never
- any
- before(Method)
- immediatelyBefore(Method)
- after(Method)
- immediatelyAfter(Method)

#### Usage
```swift
XCTAssertTrue(spyObject.check(method: .test, predicate: .before(testWithArgument(argument: 1))))
```

#### Usage with Nimble
```swift 
expect(spyObject).to(haveReceived(.test), before(.testWithArgument(argument: 1)))
```

## Author

Franco Meloni, franco.meloni91@gmail.com

## License

TestSpy is available under the MIT license. See the LICENSE file for more info.
