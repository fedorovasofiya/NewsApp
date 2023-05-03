//
//  WebViewController.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 05.02.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    private lazy var webView: WKWebView = WKWebView()
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let presenter: WebViewOutput
    
    // MARK: - Life Cycle
    
    init(presenter: WebViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "News Details"
        configureButtons()
        setupWebView()
        setupActivityIndicator()
        presenter.viewIsReady()
    }
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.doneButton, style: .plain, target: self, action: #selector (didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector (didTapRefresh))
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }

    @objc private func didTapDone() {
        presenter.didTapClose()
    }
    
    @objc private func didTapRefresh() {
        activityIndicator.startAnimating()
        webView.reload()
    }
    
    private func showAlert(with errorMessage: String) {
        let retryAction = UIAlertAction(title: L10n.retryButton, style: .destructive) { [weak self]_ in
            self?.activityIndicator.startAnimating()
            self?.webView.reload()
        }
        let okAction = UIAlertAction(title: L10n.okButton, style: .default) { _ in }
        let alertViewController = UIAlertController(title: L10n.errorTitle, message: errorMessage, preferredStyle: .alert)
        alertViewController.addAction(retryAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true)
    }
    
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showAlert(with: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
}

// MARK: - WebViewInput

extension WebViewController: WebViewInput {
    func loadURLRequest(_ request: URLRequest) {
        webView.load(request)
    }
}
