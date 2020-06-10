//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

struct Item: Decodable {
    var imagePath: String
    var filter: String
    var title: String
    var imageView: UIImageView?

    enum CodingKeys: String, CodingKey {
        case imagePath = "image"
        case filter
        case title
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.imagePath = try values.decode(String.self, forKey: .imagePath)
        self.filter = try values.decode(String.self, forKey: .filter)
        self.title = try values.decode(String.self, forKey: .title)

        self.imageView = UIImageView()
    }
}