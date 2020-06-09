//
//  ViewController.swift
//  Intern-Onboarding
//
//  Created by Brooke Porter on 6/4/20.
//  Copyright © 2020 WW International, Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, LoaderDelegate {
    static let DEBUG = false

    private var itemModel: ItemModel? = ItemModel()

    func hasLoadedJSON() {
        OperationQueue.main.addOperation({ self.tableView.reloadData() })

        if ViewController.DEBUG {
            print("JSON has loaded -- fetching images")
        }

        self.itemModel?.fetchImages()
    }

    func hasLoadedImages() {
        if ViewController.DEBUG {
            print("Images have loaded -- reloading view")
        }

        OperationQueue.main.addOperation({ self.tableView.reloadData() })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemModel?.delegate = self
        self.itemModel?.fetchJSON()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = itemModel?.items.count else {
            print("Problem getting item count")
            return 0
        }
        return count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        if let cell = cell as? ItemCell {
            guard let item = itemModel?.items[indexPath.row] else {
                print("Problem getting item cell")
                return cell
            }

            cell.setValues(using: item)

            if indexPath.section == 1 {
                cell.imageView?.image = nil
            } else if indexPath.section == 2 {
                cell.textLabel?.text = nil
            }
        }

        return cell
    }
}
