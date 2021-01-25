//
/*
 *		Created by 游宗諭 in 2020/12/30
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
extension CallstackPredicates {
    
    public struct Is<Method: Equatable>: CallstackPredicate {
        public init(verifier: @escaping (Method) -> Bool) {
            self.verifier = verifier
        }
        
        let verifier: (Method) -> Bool
        
        public func verify(method: Method) -> Bool {
            verifier(method)
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
}
public extension TestSpy {
    /// [TestSpy] check callstack with custom verifier against all methods
    /// - Parameter verifier: checking callstack all satisfy this verifer
    /// - Returns:true for correct, false for incorrect
    func check(verifier: @escaping (Method) -> Bool) -> Bool {
        return CallstackPredicates.Is(verifier: verifier).check(against: callstack.callstack)
    }
}
