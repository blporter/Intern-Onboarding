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

    private var itemModel: ItemModel = ItemModel()

    func hasLoadedImages() {
        if ViewController.DEBUG {
            print("Images have loaded -- reloading view")
        }

        DispatchQueue.main.async(execute: { self.tableView.reloadData() })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemModel.delegate = self
        self.itemModel.fetchJSON()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModel.items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? ItemCell {
            cell.setValues(using: itemModel.items[indexPath.row])

            if indexPath.section == 1 {
                cell.itemImageView.image = nil
            } else if indexPath.section == 2 {
                cell.itemText.text = nil
            }
        }

        return cell
    }
}
