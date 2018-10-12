# TestSpy

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-blue.svg)
[![Build Status](https://app.bitrise.io/app/17161483bf6ebfbb/status.svg?token=IUjjwJMbY1Z0bf_b24e_Vg&branch=master)](https://app.bitrise.io/app/17161483bf6ebfbb)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
[![Pod version](https://img.shields.io/cocoapods/v/TestSpy.svg?style=flat)](https://cocoapods.org/pods/TestSpy)
[![codecov](https://codecov.io/gh/f-meloni/TestSpy/branch/master/graph/badge.svg)](https://codecov.io/gh/f-meloni/TestSpy)

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
XCTAssertTrue(spyObject.check(method: .test, predicate: CallstackMatcher.any))
```

## Use the spy object in tests with Nimble

```swift
expect(spyObject).to(haveReceived(.test))
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
XCTAssertTrue(spyObject.check(method: .test, predicate: CallstackMatcher.before(.testWithArgument(argument: 1))))
```

#### Usage with Nimble
```swift 
expect(spyObject).to(haveReceived(.test), .before(.testWithArgument(argument: 1)))
```

## Automatically generate Spy Objects with Sourcery
[Sourcery](https://github.com/krzysztofzablocki/Sourcery) offers a good way to automatically generate spy objects.
You can find an example stancil file to generate Spy Objects  [here](https://raw.githubusercontent.com/f-meloni/TestSpy/master/SourceryExample/AutoSpy.stencil)

to use it:
- add a script phase, before the compile sources phase, in  your test project with:
```bash
sourcery --sources "$SOURCESPATH" --templates "$TEMPLATESPATH" --output "$OUTPUTPATH" --args module="$CURRENTFRAMEWORKNAME",import="Foundation",import="UIKit"...
```
- add this annotation to the protocol you want to spy `// sourcery: autoSpy`
- include the files generated at `$OUTPUTPATH` on your test project

## Author

Franco Meloni, franco.meloni91@gmail.com

## License

TestSpy is available under the MIT license. See the LICENSE file for more info.
