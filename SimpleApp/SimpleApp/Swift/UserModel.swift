//
//  UserModel.swift
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/21.
//  Copyright © 2018年 wuyp. All rights reserved.
//

import UIKit

public class UserModel: BaseModel {
    var name: String?
    var age: Int?
    
    public override init() {
        self.name = nil
        self.age = nil
        super .init()
    }
    
    @objc
    public init(name:String?, age:Int) {
        super.init()
        
        self.name = name
        self.age = age
    }
    
    @discardableResult
    public func intro() -> String {
        return "name:\(String(describing: self.name)) age:\(String(describing: self.age ?? nil))"
    }
    
    @objc
    public func rename(name: String?) {
        if let name = name {
            self.name = name
        }
        
        print("rename....")
    }
    
    @objc
    public func test() {

        
    }
    
   
}
