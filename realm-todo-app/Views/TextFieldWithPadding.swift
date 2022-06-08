//
//  TextFieldWithPadding.swift
//  realm-todo-app
//
//  Created by Truong Nhat Anh on 08/06/2022.
//

import Foundation
import UIKit

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 280,
        left: 18,
        bottom: 28,
        right: 18
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
