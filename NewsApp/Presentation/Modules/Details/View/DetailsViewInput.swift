//
//  DetailsViewInput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation
import UIKit

protocol DetailsViewInput: AnyObject {
    func showData(_ data: NewsModel)
    func showImage(_ image: UIImage?)
    func showAlert(with errorMessage: String)
}
