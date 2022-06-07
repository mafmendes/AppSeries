//
//  MovieDetailViewController.swift
//  APPSeriesNew
//
//  Created by Mendes, Mafalda Joana on 13/05/2022.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    private lazy var scrollStackViewContainer: UIStackView = {
        UIStackView()
    }()
    private lazy var titleLabel: UILabel = {
        UILabel()
    }()
    private lazy var descriptionLabel: UILabel = {
        UILabel()
    }()
    private lazy var ratingLabel: UILabel = {
        UILabel()
    }()
    private lazy var actorsLabel: UILabel = {
        UILabel()
    }()
    private lazy var downloadButton: UIButton = {
        UIButton()
    }()
    private lazy var posterImageView: UIImageView = {
        UIImageView()
    }()
    private let viewModel: MovieDetailViewModel = MovieDetailViewModel()
    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpScrollStack()
        setUpTitleLabel()
        setUpOtherLabels()
        setUpDownloadButton()
        setUpImage()
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addArrangedSubview(posterImageView)
        scrollStackViewContainer.addArrangedSubview(titleLabel)
        scrollStackViewContainer.addArrangedSubview(ratingLabel)
        scrollStackViewContainer.addArrangedSubview(actorsLabel)
        scrollStackViewContainer.addArrangedSubview(descriptionLabel)
        scrollStackViewContainer.addArrangedSubview(downloadButton)
        configureConstraints()
    }
    private func setUpScrollStack() {
        scrollStackViewContainer.axis = .vertical
    }
    private func setUpTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 0
    }
    private func setUpOtherLabels() {
        ratingLabel.font = .systemFont(ofSize: 18, weight: .regular)
        ratingLabel.numberOfLines = 0
        actorsLabel.font = .systemFont(ofSize: 18, weight: .regular)
        actorsLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.numberOfLines = 0
    }
    private func setUpDownloadButton() {
        downloadButton.backgroundColor = .red
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.setTitleColor(.white, for: .normal)
        downloadButton.layer.cornerRadius = 8
        downloadButton.layer.masksToBounds = true
        downloadButton.addTarget(self, action: #selector(popupAlert(_:)), for: .touchUpInside)
    }
    private func setUpImage() {
        posterImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    func configureConstraints() {
        let margins = view.layoutMarginsGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ]
        scrollStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        let scrollStackContainerConstraints = [
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        actorsLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollStackViewContainer.setCustomSpacing(50, after: posterImageView)
        scrollStackViewContainer.setCustomSpacing(20, after: titleLabel)
        scrollStackViewContainer.setCustomSpacing(20, after: ratingLabel)
        scrollStackViewContainer.setCustomSpacing(20, after: actorsLabel)
        scrollStackViewContainer.setCustomSpacing(20, after: descriptionLabel)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(scrollStackContainerConstraints)
    }
    public func configure(with model: MovieDetail) {
        viewModel.configureMovieDetail(
            model: model,
            posterImageView: posterImageView,
            titleLabel: titleLabel,
            descriptionLabel: descriptionLabel,
            ratingLabel: ratingLabel,
            actorsLabel: actorsLabel)
    }
}
