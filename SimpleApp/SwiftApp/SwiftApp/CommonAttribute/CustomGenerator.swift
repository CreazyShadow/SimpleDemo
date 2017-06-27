//
//  CustomGenerator.swift
//  SwiftApp
//
//  Created by wuyp on 2017/6/22.
//  Copyright © 2017年 raymond. All rights reserved.
//

import Foundation

class CustomGenerator: Sequence, IteratorProtocol {
    var count = 0
    func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1}
            return count
        }
    }
    
    lazy var source: [Int] = {
        var temp = [Int]()
        for i in 0...10 {
            temp.append(i)
        }
        
        return temp
    }()
    
    var name: String {
        willSet(newValue) {
            
        }
        
        didSet {
            
        }
    }
    
    var max: Int {
        return source.count
    }
    
    subscript(index: Int) -> Int? {
        get {
            if source.count > index {
                return source[index]
            } else {
                return nil
            }
        }
        
        set(newValue) {
            source[index] = newValue!
        }
    }
    
    init() {
        self.name = "jack"
    }
    
    init(name: String) {
        self.name = name
    }
}
