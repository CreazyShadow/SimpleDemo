//
//  RacViewController.swift
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/6/15.
//  Copyright © 2018年 wuyp. All rights reserved.
//

import UIKit

class RacViewController: UIViewController {
 
    @IBOutlet weak var stackContainer: UIStackView!
    
    fileprivate var btn3: UIButton {
        return self.view.viewWithTag(12) as! UIButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFunctionBtns(count: 4)
    }
    
    //MARK: UI
    private let kRowBtnCount: Int = 4
    private func createFunctionBtns(count: Int) {
        let width: CGFloat = (ScreenWidth - CGFloat(kRowBtnCount - 1) * 10) / CGFloat(kRowBtnCount)
        for index in 0..<count {
            let column: CGFloat = CGFloat(index % kRowBtnCount)
            let row: CGFloat = CGFloat(index / kRowBtnCount)
            let temp = UIButton(frame: CGRect(x: column * (width + 10), y: row * (25 + 10), width: width, height: 25))
            temp.backgroundColor = .green
            temp.tag = index + 10
            temp.setTitle("功能\(index)", for: .normal)
            temp.setTitleColor(UIColor.orange, for: .normal)
            temp.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
            stackContainer.addSubview(temp)
        }
    }
    
    @objc private func btnAction(btn: UIButton) {
        switch btn.tag - 10 {
        case 0:
            singleIntro()
            break
            
        case 1:
            btnAction()
            break
            
        case 2:
            break
            
        default:
            break
        }
    }
}

//MARK: 基本用法
extension RacViewController {
    fileprivate func singleIntro() {
        
    }
    
    fileprivate func btnAction() {
        
    }
}
