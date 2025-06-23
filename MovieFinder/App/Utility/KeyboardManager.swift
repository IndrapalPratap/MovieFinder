//
//  KeyboardManager.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 23/06/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Enables keyboard dismissal when tapping anywhere outside input fields.
    func enableKeyboardDismissOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    /// Dismisses the keyboard.
    @objc private func dismissKeyboardOnTap() {
        view.endEditing(true)
    }
}
