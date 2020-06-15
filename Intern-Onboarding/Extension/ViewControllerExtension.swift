//
// Created by Brooke Porter on 6/15/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func configureImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: screenBounds.size.width, height: imageHeight)
        if let image = itemModel.items[0].imageView?.image {
            imageView.image = image
        }
    }

    func configureTextView() {
        textView.frame = CGRect(x: margin,
                                y: imageHeight + margin,
                                width: screenBounds.size.width - (margin * 2),
                                height: screenBounds.size.height - imageHeight - (margin * 2))
        textView.textColor = .black
        textView.textAlignment = .justified
        textView.text = "Welcome to myWW, [name]!"
        textView.font = textView.font?.withSize(36)
        // This background color demonstrates the padding set in the frame.
        textView.backgroundColor = .lightGray
    }
}
