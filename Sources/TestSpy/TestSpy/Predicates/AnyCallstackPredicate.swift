//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

struct AnyCallstackPredicate<Method: Equatable>: CallstackPredicate {
    let _check: ([Method]) -> Bool

    let _verify: (Method) -> Bool
    let _description: (Method) -> String

    init<P: CallstackPredicate>(predicate: P) where P.Method == Method {
        _check = predicate.check(against:)
        _verify = predicate.verify(method:)
        _description = predicate.description(forMethod:)
    }

    func check(against callstack: [Method]) -> Bool {
        _check(callstack)
    }

    func verify(method: Method) -> Bool {
        _verify(method)
    }

    func description(forMethod method: Method) -> String {
        _description(method)
    }
}
