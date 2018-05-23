//
//  UserModel.swift
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/21.
//  Copyright © 2018年 wuyp. All rights reserved.
//

import UIKit

class UserModel: BaseModel {
    var name: String?
    var age: Int?
    
    @objc override init() {
        self.name = nil
        self.age = nil
        super .init()
    }
    
    convenience init(name:String?, age:Int?) {
        self.init()
        
        self.name = name
        self.age = age
    }
    
    @discardableResult
    func intro() -> String {
        return "name:\(String(describing: self.name)) age:\(String(describing: self.age ?? nil))"
    }
    
    @objc
    func rename(name: String?) {
        if let name = name {
            self.name = name
        }
    }
    
    
    func test(name: String?, age: Int?) {
        
    }
}
