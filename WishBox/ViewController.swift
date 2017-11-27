//
//  ViewController.swift
//  WishBox
//
//  Created by Shehryar Khan on 26.11.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate  = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

}

