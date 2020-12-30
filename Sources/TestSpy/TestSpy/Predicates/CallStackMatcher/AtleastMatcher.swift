//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
public extension CallstackMatchers {
    struct AtLeastMatcher<Method: Equatable>: CallstackPredicate {
        let method: Method
        let times: Int

        public func check(against callstack: [Method]) -> Bool {
            return callstack.filter(verify(method:)).count >= times
        }

        public func verify(method: Method) -> Bool {
            method == self.method
        }

        public func description(forMethod method: Method) -> String {
            return "have received \(method) at least \(times) times"
        }
    }
}
