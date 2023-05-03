//
//  NewsListAssembly.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation
import UIKit

protocol NewsListAssembly {
    func makeNewsListModule(moduleOutput: NewsListModuleOutput) -> UIViewController
}
