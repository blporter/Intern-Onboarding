//
//  ViewController.swift
//  Intern-Onboarding
//
//  Created by Brooke Porter on 6/4/20.
//  Copyright © 2020 WW International, Inc. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    let margin = CGFloat(20)

    var imageHeight = CGFloat(0)
    var itemModel = ItemModel()

    let imageView = UIImageView()
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageHeight = UIScreen.main.bounds.size.height / 2.15

        itemModel.delegate = self
        itemModel.fetchJSON()

        view.backgroundColor = .white
    }

    func setupImageView() {
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
                                     imageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: imageHeight)])

        if let image = itemModel.items[0].imageView?.image {
            imageView.image = image
        }
    }

    func setupTextView() {
        view.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
                                     textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
                                     textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin),
                                     textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin - view.safeAreaInsets.bottom)])

        textView.textColor = .black
        textView.textAlignment = .justified
        textView.text = "Welcome to myWW, [name]!"
        textView.font = textView.font?.withSize(36)
        // This background color demonstrates the margin set in the constraints.
        textView.backgroundColor = .lightGray
        textView.isEditable = false
        textView.isSelectable = false
    }
}
