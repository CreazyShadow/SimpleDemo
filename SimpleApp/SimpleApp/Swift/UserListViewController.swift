//
//  UserListViewController.swift
//  SimpleApp
//
//  Created by 邬勇鹏 on 2018/5/21.
//  Copyright © 2018年 wuyp. All rights reserved.
//

import UIKit

class UserListViewController: BaseViewController {
    
    lazy var table: UITableView = {
       let table = UITableView(frame: self.view.bounds, style: .grouped)
        table.delegate = self
        table.dataSource = self
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        return cell!
    }
}
