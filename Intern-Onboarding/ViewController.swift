//
//  ViewController.swift
//  Intern-Onboarding
//
//  Created by Brooke Porter on 6/4/20.
//  Copyright © 2020 WW International, Inc. All rights reserved.
//

import UIKit

private let baseURL = "https://www.weightwatchers.com"
private let jsonURL = "/assets/cmx/us/messages/collections.json"

private class Item: Decodable {
    var uiImage: UIImage
    var imagePath: String
    var filter: String
    var title: String

    enum CodingKeys: String, CodingKey {
        case uiImage
        case imagePath = "image"
        case filter
        case title
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.imagePath = try values.decode(String.self, forKey: .imagePath)
        self.filter = try values.decode(String.self, forKey: .filter)
        self.title = try values.decode(String.self, forKey: .title)

        self.uiImage = UIImage.init()
        if let imageURL = URL(string: "\(baseURL)\(self.imagePath)") {
            let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                    return
                }

                if let data = data {
                    self.uiImage = UIImage(data: data) ?? UIImage.init()
                }
            })
            task.resume()
        }
    }
}

class ViewController: UITableViewController {
    private var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.parseJSON()
    }

    func parseJSON() {
        guard let url = URL(string: "\(baseURL)\(jsonURL)") else {
            print("Problem with URL")
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
                    OperationQueue.main.addOperation({ self.tableView.reloadData() })
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Section \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ImageTextCell.self, forCellReuseIdentifier: "ImageTextCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTextCell", for: indexPath)

        let item: Item = self.items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.imageView?.image = item.uiImage

        if indexPath.section == 1 {
            cell.imageView?.image = nil
        } else if indexPath.section == 2 {
            cell.textLabel?.text = nil
        }

        return cell
    }
}

class ImageTextCell: UITableViewCell {}
