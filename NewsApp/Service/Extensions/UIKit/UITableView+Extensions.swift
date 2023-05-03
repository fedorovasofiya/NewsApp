//
//  UITableView+Extensions.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell & Reusable>(cellType: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as! Cell
    }

    func registerReusableCell<Cell: UITableViewCell & Reusable>(cellType: Cell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
