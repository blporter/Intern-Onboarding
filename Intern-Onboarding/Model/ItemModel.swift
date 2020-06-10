//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

class ItemModel {
    // These are just for convenience.
    static let baseURL = "https://www.weightwatchers.com"
    static let jsonURL = "/assets/cmx/us/messages/collections.json"

    var items = [Item]()
    weak var delegate: LoaderDelegate?

    func fetchJSON() {
        guard let url = URL(string: "\(ItemModel.baseURL)\(ItemModel.jsonURL)") else {
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

                    if ViewController.DEBUG {
                        print("Done fetching JSON -- sending to delegate")
                    }

                    self.delegate?.hasLoadedJSON()
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }
}