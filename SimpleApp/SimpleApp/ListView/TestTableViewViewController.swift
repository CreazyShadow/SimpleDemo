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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model: CellModel = self.source[indexPath.row]
        return model.isSelected! ? 120 : 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL")!
        cell.textLabel?.text = self.source[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model: CellModel = self.source[indexPath.row]
        model.isSelected = !model.isSelected
        let indexs: [NSIndexPath] = [indexPath]
        self.tableView .reloadRowsAtIndexPaths(indexs, withRowAnimation: .Bottom)
    }
    
    //MARK: lazy load
    
    lazy var tableView: UITableView = {
        let temp: UITableView = UITableView(frame: self.view.bounds, style: .Grouped)
        temp.delegate = self
        temp.dataSource = self
        temp.registerClass(ExpandTableViewCell.self, forCellReuseIdentifier: "CELL")
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
