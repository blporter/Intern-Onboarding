//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

class ItemModel {
    // These are just for convenience.
    private let baseURL = "https://www.weightwatchers.com"
    private let jsonURL = "/assets/cmx/us/messages/collections.json"

    var items = [Item]()

    // TODO: probably need to change tableView to pass by reference?
    func fetchJSON(tableView: UITableView) {
        guard let url = URL(string: "\(self.baseURL)\(self.jsonURL)") else {
            print("Problem with JSON URL")
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }

            if let data = data {
                do {
                    self.items = try JSONDecoder().decode([Item].self, from: data)
                    OperationQueue.main.addOperation({ tableView.reloadData() })
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }

    // TODO: images aren't loading again -> Correct to use a delegate here, and probably change tableView to pass by reference.
    func fetchImages(tableView: UITableView) {
        for i in 0..<self.items.count {
            if let url = URL(string: "\(self.baseURL)\(self.items[i].imagePath)") {
                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                    if let error = error {
                        print(error)
                        return
                    }

                    if let data = data {
                        self.items[i].image = UIImage(data: data) ?? UIImage.init()
                        OperationQueue.main.addOperation({ tableView.reloadData() })
                    }
                })
                task.resume()
            }
        }
    }
}