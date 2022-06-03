//
//  UIString.swift
//  APPSeriesNew
//
//  Created by Mendes, Mafalda Joana on 16/05/2022.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat { return 14 }
    var boldFont: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    func bold(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
