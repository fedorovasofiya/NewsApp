//
//  DetailsAssembly.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation
import UIKit

protocol DetailsAssembly {
    func makeDetailsModule(newsModel: NewsModel, moduleOutput: DetailsModuleOutput) -> UIViewController
}
