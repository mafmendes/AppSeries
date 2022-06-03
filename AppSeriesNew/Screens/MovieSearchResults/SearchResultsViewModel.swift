//
//  SearchResultsViewModel.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation

final class SearchResultsViewModel {
    func didSelectItem(movies: [Movie], delegate: SearchResultsViewControllerDelegate?, indexPath: IndexPath) {
        let moviesInfo = movies[indexPath.row]
        guard let movieName = moviesInfo.fullTitle ?? moviesInfo.title ?? Optional(""),
                let movieImage = moviesInfo.image ?? moviesInfo.image,
                let movieDescription = moviesInfo.description ?? Optional(""),
                let movieActors = moviesInfo.crew ?? moviesInfo.stars ?? Optional("")
        else {
            return
        }
        let viewModel = MovieDetail(fullTitle: movieName,
                                    title: "",
                                    imageView: movieImage,
                                    description: movieDescription,
                                    imDbRating: "",
                                    metacriticRating: "",
                                    actors: movieActors )
        delegate?.searchResultsViewControllerDidTapItem(viewModel)
    }
}
