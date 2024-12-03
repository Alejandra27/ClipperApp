//
//  NSTextFieldStyles.swift
//  ClipperApp2
//
//  Created by Mary on 3/12/24.
//

import AppKit

extension NSTextField {
    
    func switchToOriginalStyle() {
        textColor = .textColor
        setOutlineColor(NSColor.separatorColor, borderWidth: 1)
        placeholderString = ""
    }
    
   
    func swithToMissingInfoStyle(_ text: String?) {
        textColor = .red
        setOutlineColor(.red, borderWidth: 2)
        placeholderString = text ?? "Error"
    }
    
}
