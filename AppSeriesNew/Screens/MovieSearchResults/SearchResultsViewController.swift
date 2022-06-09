//
//  SearchResultsViewController.swift
//

import UIKit
import Foundation

class SearchResultsViewController: UIViewController {
    public var movies: [Movie] = [Movie]()
    weak var delegate: SearchResultsViewControllerDelegate?
    private var viewModel: SearchResultsViewModel = SearchResultsViewModel()
    public lazy var searchResultsCollectionView: UICollectionView = {
        UICollectionView()
    }()
    public lazy var noResultsLabel: UILabel = {
        UILabel()
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
        setUpLabel()
        view.addSubview(searchResultsCollectionView)
        view.addSubview(noResultsLabel)
        view.addSubview(activityIndicator)
        configureConstraints()
    }
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SearchResultsSizes.collectionViewWidth,
                                 height: SearchResultsSizes.collectionViewHeight)
        layout.minimumInteritemSpacing = 0
        searchResultsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        searchResultsCollectionView.register(CollectionViewCell.self,
                                             forCellWithReuseIdentifier: MovieListConstants.cellIdentifier)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    private func setUpLabel() {
        noResultsLabel.font = .systemFont(ofSize: 22, weight: .bold)
        noResultsLabel.numberOfLines = 0
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
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
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
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let totalHeight: CGFloat = (self.view.frame.width / 3)
        let totalWidth: CGFloat = (self.view.frame.width / 3)

        return CGSize(width: ceil(totalWidth), height: ceil(totalHeight))
    }
}
