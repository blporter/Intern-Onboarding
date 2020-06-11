//
// Created by Brooke Porter on 6/8/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

final class ItemCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    final let itemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    final let itemText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(itemImageView)
        contentView.addSubview(itemText)

        itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true

        itemText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemText.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 5).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
