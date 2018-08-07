//
//  SwiftConst.swift
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/7/16.
//  Copyright © 2018年 wuyp. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let iPhoneX = CGSize(width: ScreenWidth, height: ScreenHeight) == CGSize(width: 375.0, height: 812.0)
let StatuBarHeight: CGFloat = iPhoneX ? 44 : 20
let NavigationBarHeight: CGFloat = 44.0
let NavigationStatuBarHeight: CGFloat = StatuBarHeight + NavigationBarHeight
let BottomSafeHeight: CGFloat = iPhoneX ? 34 : 0
let ToolBarHeight: CGFloat = 49 + (iPhoneX ? BottomSafeHeight : 0)

