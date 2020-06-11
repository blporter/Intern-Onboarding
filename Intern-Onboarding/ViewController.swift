//
//  ViewController.swift
//  Intern-Onboarding
//
//  Created by Brooke Porter on 6/4/20.
//  Copyright © 2020 WW International, Inc. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UITableViewController, LoaderDelegate {
    static let DEBUG = false

    private var itemModel: ItemModel = ItemModel()

    func hasLoadedImages() {
        if ViewController.DEBUG {
            print("Images loaded -- reloading data")
        }
        DispatchQueue.main.async(execute: { self.tableView.reloadData() })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        itemModel.delegate = self
        itemModel.fetchJSON()
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
            let item = itemModel.items[indexPath.row]

            switch indexPath.section {
            case 1:
                cell.itemText.text = item.title
                cell.itemImageView.image = nil
            case 2:
                cell.itemText.text = nil
                cell.itemImageView.image = item.imageView?.image
            default:
                cell.itemText.text = item.title
                cell.itemImageView.image = item.imageView?.image
            }
        }

        return cell
    }
}
