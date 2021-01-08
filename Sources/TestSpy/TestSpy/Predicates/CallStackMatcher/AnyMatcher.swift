//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
public extension CallstackPredicates {
    struct AnyMatcher<Method: Equatable>: CallstackPredicate {
        let method: Method

        public func verify(method: Method) -> Bool {
            self.method == method
        }

        public func check(against callstack: [Method]) -> Bool {
            callstack.contains(method)
        }

        public func description(forMethod method: Method) -> String {
            "have received \(method)"
        }
    }
}
