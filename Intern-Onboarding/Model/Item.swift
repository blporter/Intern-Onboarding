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

        imagePath = try values.decode(String.self, forKey: .imagePath)
        filter = try values.decode(String.self, forKey: .filter)
        title = try values.decode(String.self, forKey: .title)

        imageView = UIImageView()
    }
}