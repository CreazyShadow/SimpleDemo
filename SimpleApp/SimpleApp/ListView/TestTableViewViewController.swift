//
//  TestTableViewViewController.swift
//  SimpleApp
//
//  Created by wuyp on 16/8/7.
//  Copyright © 2016年 wuyp. All rights reserved.
//

import UIKit

@objc(TestTableViewViewController)

class TestTableViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: tableView delegate & datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model: CellModel = self.source[(indexPath as NSIndexPath).row]
        return model.isSelected! ? 120 : 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL")!
        cell.textLabel?.text = self.source[(indexPath as NSIndexPath).row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: CellModel = self.source[(indexPath as NSIndexPath).row]
        model.isSelected = !model.isSelected
        let indexs: [IndexPath] = [indexPath]
        self.tableView .reloadRows(at: indexs, with: .bottom)
    }
    
    //MARK: lazy load
    
    lazy var tableView: UITableView = {
        let temp: UITableView = UITableView(frame: self.view.bounds, style: .grouped)
        temp.delegate = self
        temp.dataSource = self
        temp.register(ExpandTableViewCell.self, forCellReuseIdentifier: "CELL")
        return temp
    }()
    
    lazy var source: [CellModel] = {
        var temp: [CellModel] = []
        
        for i in 1...10 {
            let model: CellModel = CellModel()
            model.name = "AAA\(i)"
            model.isSelected = false
            temp.append(model)
        }
        
        return temp
        
    }()
}
