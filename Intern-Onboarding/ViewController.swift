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
    let screenBounds = UIScreen.main.bounds
    let margin = CGFloat(20)

    var imageHeight = CGFloat(0)
    var itemModel = ItemModel()

    let imageView = UIImageView()
    let textView = UITextView()

    override func viewDidLoad() {
        view.addSubview(imageView)
        view.addSubview(textView)

        imageHeight = screenBounds.size.height / 2.15

        super.viewDidLoad()

        itemModel.delegate = self
        itemModel.fetchJSON()

        view.backgroundColor = .white
    }
}
