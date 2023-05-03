//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 05.02.2023.
//

import UIKit

final class NewsCell: UITableViewCell {

    struct DisplayData: Hashable {
        let id: UUID = UUID()
        let title: String
        let subTitle: String
    }
    
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var subtitleLabel: UILabel = UILabel()
    private lazy var newsImageView: UIImageView = UIImageView()
    private lazy var placeholder = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setupSubtitleLabel()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    // MARK: - UI Setup
    
    private func setupImageView() {
        newsImageView.image = placeholder
        newsImageView.tintColor = .secondarySystemBackground
        newsImageView.layer.cornerRadius = 6
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            newsImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -Constants.largeSpacing),
            newsImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -Constants.largeSpacing),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
        ])
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .light)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            subtitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -Constants.spacing)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -Constants.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: subtitleLabel.topAnchor, constant: -Constants.spacing)
        ])
    }
    
}

// MARK: - Configurable

extension NewsCell: Configurable {
    typealias ConfigurationModel = DisplayData
    
    func configure(with model: DisplayData) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
        newsImageView.image = placeholder
    }
}

// MARK: - ImageConfigurable

extension NewsCell: ImageConfigurable {
    func configure(with image: UIImage?) {
        newsImageView.image = image
    }
}

// MARK: - Constants

extension NewsCell {
    private struct Constants {
        static let spacing: CGFloat = 10
        static let largeSpacing: CGFloat = 20
    }
}
