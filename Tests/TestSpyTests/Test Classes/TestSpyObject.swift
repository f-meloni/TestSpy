//
//  TestSpyObject.swift
//  TestSpyTests
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//

import TestSpy

struct TestSpyObject: TestSpy {
    var callstack = CallstackContainer<TestMethod>()
}
