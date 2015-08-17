//
//  ViewController.swift
//  PronounceHero
//
//  Created by Stan on 8/14/15.
//  Copyright © 2015 Stan. All rights reserved.
//

import UIKit

import PureLayout
import HysteriaPlayer

struct Constants {
    static let kCellIdentifier: String  = "kCellIdentifier"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HysteriaPlayerDelegate, HysteriaPlayerDataSource {
    weak var tableView: UITableView?
    lazy var items = [Vocabulary]()
    lazy var hysteriaPlayer = HysteriaPlayer.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        initCustomViews()
        prepareDatasets()
        initHysteriaPlayer()
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
                        items.append(Vocabulary(name: key as! String, filePath: value as! String))
                    }
                }
            }
        }
    }
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: Constants.kCellIdentifier)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        hysteriaPlayer.fetchAndPlayPlayerItem(indexPath.row)
    }
    
    // MARK: - HysteriaPlayer
    
    func initHysteriaPlayer() {
        hysteriaPlayer.delegate = self
        hysteriaPlayer.datasource = self
        hysteriaPlayer.enableMemoryCached(false)
    }
    
    func hysteriaPlayerNumberOfItems() -> Int {
        return items.count
    }
    
    func hysteriaPlayerURLForItemAtIndex(index: Int, preBuffer: Bool) -> NSURL! {
        if let path = NSBundle.mainBundle().pathForResource(items[index].filePath, ofType: "mp3") {
            return NSURL(fileURLWithPath: path)
        }
        
        return NSURL()
    }
    
    func hysteriaPlayerReadyToPlay(identifier: HysteriaPlayerReadyToPlay) {
        hysteriaPlayer.play()
    }
    
}

