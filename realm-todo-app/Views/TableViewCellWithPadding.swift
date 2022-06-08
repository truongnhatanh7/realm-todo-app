//
//  TableViewCellWithPadding.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 08/06/2022.
//

import Foundation
import UIKit

class TableViewCellWithPadding: UITableViewCell {
    var padding = UIEdgeInsets(
        top: 28,
        left: 0,
        bottom: 28,
        right: 0
    )
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: padding)
    }
}
