//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

// import Foundation
public struct CallStackVerifyer<Method: Equatable>: CallstackPredicate {
    init(verifyer: @escaping (Method) -> Bool) {
        self.verifyer = verifyer
    }

    let verifyer: (Method) -> Bool

    public func verify(method: Method) -> Bool {
        verifyer(method)
    }

    public func check(against callstack: [Method]) -> Bool {
        callstack.allSatisfy {
            self.verify(method: $0)
        }
    }

    public func description(forMethod method: Method) -> String {
        "have received \(method)"
    }
}

public extension TestSpy {
    func check(verifeyer: @escaping (Method) -> Bool) -> Bool {
        return CallStackVerifyer(verifyer: verifeyer).check(against: callstack.callstack)
    }
}
