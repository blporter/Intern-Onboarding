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

    final private let itemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    final private let itemText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    final private func setConstraints() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemText)

        NSLayoutConstraint.activate([
                                        itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                        itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                        itemImageView.widthAnchor.constraint(equalToConstant: 70),
                                        itemImageView.heightAnchor.constraint(equalToConstant: 45),

                                        itemText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                        itemText.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 5),
                                    ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setValues(text: String?, image: UIImage?) {
        itemText.text = text
        itemImageView.image = image
    }
}
