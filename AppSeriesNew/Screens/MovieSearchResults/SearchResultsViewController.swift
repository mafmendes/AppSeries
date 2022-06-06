//
//  SearchResultsViewController.swift
//

import UIKit
import Foundation
#warning("Alguns filmes ficam sobrepostos uns em cima dos outros -> ver cena de grouped se está bem")
class SearchResultsViewController: UIViewController {
    public var movies: [Movie] = [Movie]()
    weak var delegate: SearchResultsViewControllerDelegate?
    private var viewModel: SearchResultsViewModel = SearchResultsViewModel()
    #warning("Why not private/lazy vars?")
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SearchResultsSizes.collectionViewWidth,
                                 height: SearchResultsSizes.collectionViewHeight)
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: MovieListConstants.cellIdentifier)
        return collectionView
    }()
    public let noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpCollectionView()
        view.addSubview(searchResultsCollectionView)
        view.addSubview(noResultsLabel)
        view.addSubview(activityIndicator)
        configureConstraints()
    }
    private func setUpCollectionView() {
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        activityIndicator.color = .systemGray
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    func configureConstraints() {
        let noResultsLabelConstraints = [
                    noResultsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
                    noResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    noResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
                ]
        NSLayoutConstraint.activate(noResultsLabelConstraints)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListConstants.cellIdentifier,
            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie.image ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(movies: movies, delegate: delegate, indexPath: indexPath)
    }
}
