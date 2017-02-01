//
//  NonEditTextField.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2017. 2. 1..
//  Copyright © 2017년 유정우. All rights reserved.
//

import UIKit

class NonEditTextField: UITextField {

    override func caretRect(for position: UITextPosition) -> CGRect {
    return CGRect.zero
    }
    
    override func selectionRects(for range: UITextRange) -> [Any] {
    return []
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    
    if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
    
    return false
    }
    
    return super.canPerformAction(action, withSender: sender)
    }

}
