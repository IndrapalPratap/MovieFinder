//
//  UILabel+Extension.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 20/06/25.
//

import Foundation
import UIKit


extension UILabel {
    
    func applyHeadingStyle(fontSize: CGFloat = 18) {
        self.font = .boldSystemFont(ofSize: fontSize)
        self.textColor = .white
    }
    
    func applyDescriptionStyle(fontSize: CGFloat = 14) {
        self.font = .systemFont(ofSize: fontSize)
        self.textColor = .white
        self.numberOfLines = 0
    }
    
    func applySubheadingStyle(fontSize: CGFloat = 16) {
        self.font = .systemFont(ofSize: fontSize, weight: .semibold)
        self.textColor = .lightGray
    }
    
    func applyRatingStyle(fontSize: CGFloat = 16) {
        self.font = .boldSystemFont(ofSize: fontSize)
        self.textColor = .systemYellow
    }
}
