//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    let itemImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    let itemText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(itemText)

        self.itemImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.itemImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.itemImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true

        self.itemText.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.itemText.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 5).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setValues(using item: Item) {
        self.itemText.text = item.title
        self.itemImageView.image = item.image
    }
}
