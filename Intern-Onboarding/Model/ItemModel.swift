//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

final class ItemModel {
    // These are just for convenience.
    static let baseURL = "https://www.weightwatchers.com"
    static let jsonURL = "/assets/cmx/us/messages/collections.json"

    var items = [Item]()
    weak var delegate: LoaderDelegate?

    final func fetchJSON() {
        guard let url = URL(string: "\(ItemModel.baseURL)\(ItemModel.jsonURL)") else {
            print("Problem with JSON URL")
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error as Any)
                return
            }

            // This optional binding is required to allow the task to throw.
            if let data = data {
                do {
                    self.items = try JSONDecoder().decode([Item].self, from: data)

                    if ViewController.DEBUG {
                        print("Done fetching JSON -- sending to delegate")
                    }
                    self.fetchImages()
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }

    final func fetchImages() {
        for i in 0..<items.count {
            if let url = URL(string: "\(ItemModel.baseURL)\(items[i].imagePath)") {
                if ViewController.DEBUG {
                    print("Fetching image from \(url)")
                }
                items[i].imageView?.sd_setImage(with: url, completed: { (image, error, cache, url) in
                    if error != nil {
                        print(error as Any)
                        return
                    }

                    self.delegate?.hasLoadedImages()
                })
            }
        }
    }
}
