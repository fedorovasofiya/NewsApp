//
//  WebAssembly.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation
import UIKit

protocol WebAssembly {
    func makeWebModule(url: URL, moduleOutput: WebModuleOutput) -> UIViewController
}

