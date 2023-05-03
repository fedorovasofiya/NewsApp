//
//  ViewController.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 05.02.2023.
//

import UIKit
import CoreData

final class NewsListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var tableView: UITableView = UITableView()
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private lazy var dataSource: UITableViewDiffableDataSource<Int, NewsCell.DisplayData> = makeDataSource()
    private lazy var refreshControl = UIRefreshControl()
    
    private let presenter: NewsListViewOutput
    
    // MARK: - Life Cycle
    
    init(presenter: NewsListViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupLoadingView()
        presenter.viewIsReady()
    }
    
    // MARK: - UI Setup
    
    private func setupLoadingView() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.registerReusableCell(cellType: NewsCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Int, NewsCell.DisplayData> {
        UITableViewDiffableDataSource<Int, NewsCell.DisplayData>(tableView: tableView) { [weak self] tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(cellType: NewsCell.self)
            self?.presenter.loadImageData(for: indexPath.row) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        cell.configure(with: UIImage(data: data))
                    }
                case .failure:
                    break
                }
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    // MARK: - Actions
    
    @objc private func didPullToRefresh() {
        presenter.reload()
        refreshControl.endRefreshing()
    }

}

// MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            presenter.loadMore()
        }
    }
    
}

extension NewsListViewController: NewsListViewInput {
    
    func setLoading(enabled: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if enabled {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showData(_ data: [NewsCell.DisplayData]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var shapshot = NSDiffableDataSourceSnapshot<Int, NewsCell.DisplayData>()
            shapshot.appendSections([0])
            shapshot.appendItems(data, toSection: 0)
            self.dataSource.apply(shapshot, animatingDifferences: false)
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
