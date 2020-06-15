//
// Created by Brooke Porter on 6/12/20.
// Copyright (c) 2020 WW International, Inc. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: LoaderDelegate {
    func hasLoadedImages() {
        if let tableView = self.view as? UITableView {
            DispatchQueue.main.async(execute: { tableView.reloadData() })
        } else {
            // For the FP-2400 ticket
            configureImageView()
            configureTextView()
        }
    }
}
