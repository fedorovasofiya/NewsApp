//
//  UITableViewCell+Extensions.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
