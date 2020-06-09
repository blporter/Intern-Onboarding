//
//  ViewController.swift
//  Intern-Onboarding
//
//  Created by Brooke Porter on 6/4/20.
//  Copyright © 2020 WW International, Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private var itemModel = ItemModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemModel.fetchJSON(tableView: self.tableView)
        self.itemModel.fetchImages(tableView: self.tableView)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModel.items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        if let cell = cell as? ItemCell {
            cell.setValues(using: itemModel.items[indexPath.row])

            if indexPath.section == 1 {
                cell.imageView?.image = nil
            } else if indexPath.section == 2 {
                cell.textLabel?.text = nil
            }
        }

        return cell
    }
}
