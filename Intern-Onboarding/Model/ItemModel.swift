//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

final class ItemModel {
    // These are just for convenience.
    private static let baseURL = "https://www.weightwatchers.com"
    private static let jsonURL = "/assets/cmx/us/messages/collections.json"

    public var items = [Item]()
    weak var delegate: LoaderDelegate?

    final func fetchJSON() {
        guard let url = URL(string: "\(ItemModel.baseURL)\(ItemModel.jsonURL)") else {
            print("Problem with JSON URL")
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print(error as Any)
                return
            }
            if error != nil && statusCode != 200 {
                print("Status Code \(statusCode): \(error as Any)")
                return
            }

            // This optional binding is required to allow the task to throw.
            if let data = data {
                do {
                    self.items = try JSONDecoder().decode([Item].self, from: data)
                    self.fetchImages()
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }

    final func fetchImages() {
        let dispatchGroup = DispatchGroup()

        for i in 0..<items.count {
            dispatchGroup.enter()

            if let url = URL(string: "\(ItemModel.baseURL)\(items[i].imagePath)") {
                items[i].imageView?.sd_setImage(with: url, completed: { (image, error, cache, url) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    dispatchGroup.leave()
                })
            }
        }

        dispatchGroup.notify(queue: .main, execute: { self.delegate?.hasLoadedImages() })
    }
}
