//
//  FontManager.swift
//  Bankapp
//
//  Created by Erik Ciau on 23/08/23.
//
import UIKit
extension UIFont {
    enum FontSize {
        case s, m, l, xl, xxl, xxxl, custom(size: CGFloat)
        var size: CGFloat {
            switch self {
            case .s: return 12
            case .m: return 14
            case .l: return 16
            case .xl: return 18
            case .xxl: return 22
            case .xxxl: return 24
            case .custom(let size): return size
            }
        }
    }
    static func setFont(size: FontSize, weight: Weight) -> UIFont {
        return .systemFont(ofSize: size.size, weight: weight)
    }
}
extension UIColor {
    enum CustomColor: String {
        case primaryBackground = "PrimaryColor"
        case secondaryBackground = "SecondaryColor"
        case primaryText = "PrimaryText"
    }
    static func setColorFont(_ color: CustomColor) -> UIColor {
        UIColor(named: color.rawValue) ?? .blue
    }
}
