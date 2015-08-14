//
//  ViewController.swift
//  PronounceHero
//
//  Created by Stan on 8/14/15.
//  Copyright © 2015 Stan. All rights reserved.
//

import UIKit

import PureLayout

struct Constants {
    static let kCellIdentifier: String  = "kCellIdentifier"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var tableView: UITableView?
    lazy var items = [(key: String, path: String)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        initCustomViews()
        prepareDatasets()
    }

    func setupSubviews() {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        self.tableView = tableView;
    }
    
    func initCustomViews() {
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        self.tableView?.estimatedRowHeight = 50;
    }
    
    func prepareDatasets() {
        if let path = NSBundle.mainBundle().pathForResource("vocabulary-book", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) {
                for pair in array as! [NSDictionary] {
                    for (key, value) in pair {
                        items.append((key as! String, value as! String))
                    }
                }
            }
        }
        print(items[0].key)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: Constants.kCellIdentifier)
        cell.textLabel?.text = items[indexPath.row].key
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

