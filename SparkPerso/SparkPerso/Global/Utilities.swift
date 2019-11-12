//
//  Utilities.swift
//  SparkPerso
//
//  Created by Mickaël Debalme on 17/10/2019.
//  Copyright © 2019 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

// Logs in the console and in an UITextView
func log(textView:UITextView, message:String) {
    // Log in console
    print(message)
    
    // Log in textView
    textView.text = textView.text + "\n" + message
    scrollToBottomOfUiTextView(textView: textView)
    
}

// Scrolls to the bottom of an UITextView
func scrollToBottomOfUiTextView(textView:UITextView) {
    let range = NSMakeRange(textView.text.count - 1, 0)
    textView.scrollRangeToVisible(range)
}
