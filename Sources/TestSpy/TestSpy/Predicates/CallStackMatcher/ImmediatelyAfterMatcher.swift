//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
public extension CallstackPredicates {
    struct ImmediatelyAfterMatcher<Method: Equatable>: CallstackPredicate {
        let method: Method
        let otherMethod: Method

        public func check(against callstack: [Method]) -> Bool {
            return check(method: method, isImmediatelyAfter: otherMethod, onCallstack: callstack)
        }

        public func verify(method: Method) -> Bool {
            method == self.method
        }

        public func description(forMethod method: Method) -> String {
            return "have received \(method) immediately after \(otherMethod)"
        }

        private func check(method _: Method, isImmediatelyAfter otherMethod: Method, onCallstack callstack: [Method]) -> Bool {
            guard let methodIndex = callstack.firstIndex(where: verify(method:)),
                  let otherMethodIndex = callstack.firstIndex(of: otherMethod)
            else {
                return false
            }

            return methodIndex == otherMethodIndex + 1
        }
    }
}
