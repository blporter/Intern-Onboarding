//
//  ViewController.swift
//  Intern-Onboarding
//
//  Created by Brooke Porter on 6/4/20.
//  Copyright © 2020 WW International, Inc. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var itemModel = ItemModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = UITableView()
        (view as? UITableView)?.dataSource = self
        (view as? UITableView)?.delegate = self

        itemModel.delegate = self
        itemModel.fetchJSON()
    }
}
