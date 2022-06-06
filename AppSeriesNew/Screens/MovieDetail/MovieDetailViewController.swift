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
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private lazy var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
#warning("METER BOTAO A MANDAR ALERTA")
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        return imageView
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    func configureConstraints() {
        let margins = view.layoutMarginsGuide
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ]
        let scrollStackContainerConstraints = [
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        scrollStackViewContainer.setCustomSpacing(50, after: posterImageView)
        scrollStackViewContainer.setCustomSpacing(20, after: titleLabel)
        scrollStackViewContainer.setCustomSpacing(20, after: ratingLabel)
        scrollStackViewContainer.setCustomSpacing(20, after: actorsLabel)
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
