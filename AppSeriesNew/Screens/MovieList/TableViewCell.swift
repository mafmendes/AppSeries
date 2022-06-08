//
//  CollectionViewTableViewCell.swift
//  APPSeriesNew
//
//  Created by Mendes, Mafalda Joana on 11/05/2022.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var moviesInformation: [Movie] = [Movie]()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: MovieListConstants.cellIdentifier)
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    public func configure(with moviesInfo: [Movie]) {
        self.moviesInformation = moviesInfo
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListConstants.cellIdentifier,
                                                            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let image = moviesInformation[indexPath.row].image else {
            return UICollectionViewCell()
        }
        cell.configure(with: image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesInformation.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let moviesInfo = moviesInformation[indexPath.row]
        guard let movieName = moviesInfo.fullTitle ?? moviesInfo.fullTitle,
                let movieImage = moviesInfo.image ?? moviesInfo.image,
                let movieImDBRating = moviesInfo.imDbRating ?? Optional(""),
                let movieMetaCriticRating = moviesInfo.metacriticRating ?? Optional(""),
                let movieDescription = moviesInfo.plot ?? Optional(""),
                let movieActors = moviesInfo.crew ?? moviesInfo.stars
        else {
            return
        }
        let viewModel = MovieDetail(fullTitle: movieName, title: movieName,
                                    imageView: movieImage,
                                    description: movieDescription,
                                    imDbRating: movieImDBRating,
                                    metacriticRating: movieMetaCriticRating,
                                    actors: movieActors)
        delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel)
    }
}
