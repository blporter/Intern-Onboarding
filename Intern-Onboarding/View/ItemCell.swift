//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    func setValues(using item: Item) {
        self.textLabel?.text = item.title
        self.imageView?.image = item.image
    }
}
