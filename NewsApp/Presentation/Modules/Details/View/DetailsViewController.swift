//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 05.02.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    private lazy var newsImageView: UIImageView = UIImageView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var dateLabel = UILabel()
    private lazy var sourceLabel = UILabel()
    private lazy var readMoreButton = UIButton(type: .system)
    
    private let presenter: DetailsViewOutput
    
    // MARK: - Life Cycle
    
    init(presenter: DetailsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News Details"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground

        setupNewsImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupDateLabel()
        setupSourceLabel()
        setupReadMoreButton()
        presenter.viewIsReady()
    }
    
    private func setupNewsImageView() {
        newsImageView.image = UIImage(systemName: "photo")
        newsImageView.tintColor = .secondarySystemBackground
        newsImageView.layer.cornerRadius = 6
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.spacing),
            newsImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: Constants.spacing),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.textAlignment = .right
        dateLabel.numberOfLines = 1
        dateLabel.font = .italicSystemFont(ofSize: 14)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.spacing),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setupSourceLabel() {
        sourceLabel.textAlignment = .right
        sourceLabel.numberOfLines = 1
        sourceLabel.font = .italicSystemFont(ofSize: 14)
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sourceLabel)

        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.smallSpacing),
            sourceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            sourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing)
        ])
    }
    
    private func setupReadMoreButton() {
        readMoreButton.setTitle(L10n.readMoreButton, for: .normal)
        readMoreButton.titleLabel?.font = .systemFont(ofSize: 17)
        readMoreButton.addTarget(self, action: #selector(didTapReadMore), for: .touchUpInside)
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            readMoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readMoreButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: Constants.spacing)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapReadMore() {
        presenter.didTapReadMore()
    }

}

extension DetailsViewController: DetailsViewInput {
    
    func showData(_ data: NewsModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.titleLabel.text = data.title
            self.descriptionLabel.text = data.text
            self.dateLabel.text = "Published at: \(data.publishedAt)"
            self.sourceLabel.text = "Source: \(data.source)"
        }
    }
    
    func showImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.newsImageView.image = image
        }
    }
    
    func showAlert(with errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let retryAction = UIAlertAction(title: L10n.retryButton, style: .destructive) { _ in
                self.presenter.reload()
            }
            let okAction = UIAlertAction(title: L10n.okButton, style: .default) { _ in }
            let alertViewController = UIAlertController(title: L10n.errorTitle, message: errorMessage, preferredStyle: .alert)
            alertViewController.addAction(retryAction)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true)
        }
    }
    
}

// MARK: - Constants

extension DetailsViewController {
    private struct Constants {
        static let spacing: CGFloat = 10
        static let smallSpacing: CGFloat = 5
        static let imageHeight: CGFloat = 220
    }
}
