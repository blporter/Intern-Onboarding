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
    var delegate: LoaderDelegate?

    func fetchJSON() {
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

    func fetchImages() {
        for i in 0..<self.items.count {
            if let url = URL(string: "\(self.baseURL)\(self.items[i].imagePath)") {
                if ViewController.DEBUG {
                    print("Fetching image from \(url)")
                }

                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                    if let error = error {
                        print(error)
                        return
                    }

                    // TODO:    calling the delegate here each time an image is loaded means the table is reloading
                    // TODO:    as many times as there are images. Is there a better way?
                    if let data = data {
                        self.items[i].image = UIImage(data: data) ?? UIImage.init()
                        self.delegate?.hasLoadedImages()
                    }
                })
                task.resume()
            }
        }
    }
}