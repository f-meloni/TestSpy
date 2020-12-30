//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
public extension CallstackMatchers {
    struct NeverMatcher<Method: Equatable>: CallstackPredicate {
        let expected: Method

        public func verify(method: Method) -> Bool {
            expected != method
        }

        public func check(against callstack: [Method]) -> Bool {
            callstack.allSatisfy(verify(method:))
        }

        public func description(forMethod method: Method) -> String {
            "have not received \(method)"
        }
    }
}
